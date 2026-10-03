import { appendFileSync, existsSync, mkdirSync, readFileSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, join } from "node:path";
import { CustomEditor, type ExtensionAPI } from "@earendil-works/pi-coding-agent";

const HISTORY_LIMIT = 100;

type HistoryEntry = {
	text: string;
	timestamp: number;
};

function resolveHistoryPath(): string {
	const agentDir = process.env.PI_CODING_AGENT_DIR ?? join(homedir(), ".pi", "agent");
	return join(agentDir, "prompt-history.jsonl");
}

function readGlobalPrompts(path: string): string[] {
	if (!existsSync(path)) return [];

	const prompts: string[] = [];
	for (const line of readFileSync(path, "utf8").split("\n")) {
		const trimmed = line.trim();
		if (!trimmed) continue;
		try {
			const entry = JSON.parse(trimmed) as Partial<HistoryEntry>;
			if (typeof entry.text === "string" && entry.text.trim()) prompts.push(entry.text);
		} catch {
			continue;
		}
	}
	return prompts.slice(-HISTORY_LIMIT);
}

function persistPrompt(path: string, text: string): void {
	const entry: HistoryEntry = { text, timestamp: Date.now() };
	mkdirSync(dirname(path), { recursive: true });
	appendFileSync(path, `${JSON.stringify(entry)}\n`);
}

class GlobalHistoryEditor extends CustomEditor {
	constructor(prompts: string[], ...args: ConstructorParameters<typeof CustomEditor>) {
		super(...args);
		for (const prompt of prompts) {
			this.addToHistory(prompt);
		}
	}
}

export default function globalPromptHistory(pi: ExtensionAPI): void {
	const historyPath = resolveHistoryPath();

	pi.on("input", (event, ctx) => {
		if (ctx.mode !== "tui" || event.source !== "interactive") return;
		const text = event.text.trim();
		if (!text) return;
		persistPrompt(historyPath, text);
	});

	pi.on("session_start", (_event, ctx) => {
		if (ctx.mode !== "tui") return;
		ctx.ui.setEditorComponent((tui, theme, keybindings) => {
			return new GlobalHistoryEditor(readGlobalPrompts(historyPath), tui, theme, keybindings);
		});
	});
}
