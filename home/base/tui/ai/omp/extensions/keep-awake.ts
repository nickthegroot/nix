import { spawn, type ChildProcess } from "node:child_process";
import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";

interface InhibitorCommand {
  command: string;
  args: readonly string[];
}

function inhibitorCommand(platform: NodeJS.Platform, agentPid: number): InhibitorCommand | undefined {
  switch (platform) {
    case "darwin":
      return {
        command: "caffeinate",
        args: ["-i", "-w", String(agentPid)],
      };
    case "linux":
      return {
        command: "systemd-inhibit",
        args: [
          "--what=idle:sleep:handle-lid-switch",
          "--who=omp",
          "--why=OMP agent session is running",
          "--mode=block",
          "cat",
        ],
      };
    default:
      return undefined;
  }
}

export default function keepAwake(pi: ExtensionAPI): void {
  const inhibitorSpec = inhibitorCommand(process.platform, process.pid);
  if (!inhibitorSpec) return;

  const holders = new Set<object>();
  let inhibitor: ChildProcess | undefined;

  const releaseInhibitor = (): void => {
    if (!inhibitor) return;
    const child = inhibitor;
    inhibitor = undefined;
    child.stdin?.end();
    child.kill();
  };

  const acquireInhibitor = (): void => {
    if (inhibitor) return;
    const child = spawn(inhibitorSpec.command, inhibitorSpec.args, {
      stdio: ["pipe", "ignore", "ignore"],
    });
    child.on("error", (error: Error) => {
      pi.logger.warn(`keep-awake: failed to start ${inhibitorSpec.command}`, {
        error: String(error),
      });
      if (inhibitor === child) inhibitor = undefined;
    });
    child.on("exit", () => {
      if (inhibitor === child) inhibitor = undefined;
    });
    child.unref();
    inhibitor = child;
  };

  pi.on("agent_start", (_event, ctx) => {
    holders.add(ctx.sessionManager);
    acquireInhibitor();
  });

  pi.on("agent_end", (event, ctx) => {
    if (event.willContinue) return;
    holders.delete(ctx.sessionManager);
    if (holders.size === 0) releaseInhibitor();
  });

  pi.on("session_shutdown", (_event, ctx) => {
    holders.delete(ctx.sessionManager);
    if (holders.size === 0) releaseInhibitor();
  });
}
