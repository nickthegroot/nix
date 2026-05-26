{
  programs.nixvim = {
    plugins = {
      octo = {
        enable = true;
        settings = {
          picker = "snacks";
          enable_builtin = true;
          mappings =
            let
              # comments (gc)
              discussion_options = {
                lhs = "<CR>";
                desc = "show discussion options";
              };
              add_comment = {
                lhs = "<leader>gcO";
                desc = "add comment";
              };
              add_reply = {
                lhs = "<leader>gco";
                desc = "add reply";
              };
              delete_comment = {
                lhs = "<leader>gcd";
                desc = "delete comment";
              };
              next_comment = {
                lhs = "]c";
                desc = "go to next comment";
              };
              prev_comment = {
                lhs = "[c";
                desc = "go to previous comment";
              };
              comment_edits = {
                lhs = "<leader>gcE";
                desc = "show comment edit history";
              };
              reference_in_new_issue = {
                lhs = "<leader>gcR";
                desc = "reference comment in new issue";
              };
              add_suggestion = {
                lhs = "<leader>gcs";
                desc = "add suggestion to comment";
              };

              # reactions (gcr)
              react_hooray = {
                lhs = "<leader>gcrp";
                desc = "add/remove 🎉 reaction";
              };
              react_heart = {
                lhs = "<leader>gcrh";
                desc = "add/remove ❤️ reaction";
              };
              react_eyes = {
                lhs = "<leader>gcre";
                desc = "add/remove 👀 reaction";
              };
              react_thumbs_up = {
                lhs = "<leader>gcr+";
                desc = "add/remove 👍 reaction";
              };
              react_thumbs_down = {
                lhs = "<leader>gcr-";
                desc = "add/remove 👎 reaction";
              };
              react_rocket = {
                lhs = "<leader>gcrr";
                desc = "add/remove 🚀 reaction";
              };
              react_laugh = {
                lhs = "<leader>gcrl";
                desc = "add/remove 😄 reaction";
              };
              react_confused = {
                lhs = "<leader>gcrc";
                desc = "add/remove 😕 reaction";
              };

              # issues (gi)
              issue_options = {
                lhs = "<CR>";
                desc = "show issue options";
              };
              close_issue = {
                lhs = "<leader>gix";
                desc = "close issue";
              };
              reopen_issue = {
                lhs = "<leader>giu";
                desc = "reopen issue";
              };
              goto_issue = {
                lhs = "<leader>gio";
                desc = "navigate to a local repo issue";
              };
              list_issues = {
                lhs = "<leader>gil";
                desc = "list open issues on same repo";
              };

              create_issue = {
                lhs = "<leader>gio";
                desc = "create issue";
              };

              # pull requests (gp)
              pr_options = {
                lhs = "<CR>";
                desc = "show PR options";
              };
              checkout_pr = {
                lhs = "<leader>gpc";
                desc = "checkout PR";
              };
              merge_pr = {
                lhs = "<leader>gpmc";
                desc = "merge commit PR";
              };
              squash_and_merge_pr = {
                lhs = "<leader>gpms";
                desc = "squash and merge PR";
              };
              rebase_and_merge_pr = {
                lhs = "<leader>gpmr";
                desc = "rebase and merge PR";
              };
              merge_pr_queue = {
                lhs = "<leader>gpmqc";
                desc = "merge commit PR and add to merge queue (Merge queue must be enabled in the repo)";
              };
              squash_and_merge_queue = {
                lhs = "<leader>gpmqs";
                desc = "squash and add to merge queue (Merge queue must be enabled in the repo)";
              };
              rebase_and_merge_queue = {
                lhs = "<leader>gpmqr";
                desc = "rebase and add to merge queue (Merge queue must be enabled in the repo)";
              };
              list_commits = {
                lhs = "<leader>gpc";
                desc = "list PR commits";
              };
              list_changed_files = {
                lhs = "<leader>gpf";
                desc = "list PR changed files";
              };
              show_pr_diff = {
                lhs = "<leader>gpd";
                desc = "show PR diff";
              };
              add_reviewer = {
                lhs = "<leader>gpri";
                desc = "add reviewer";
              };
              remove_reviewer = {
                lhs = "<leader>gprx";
                desc = "remove reviewer request";
              };
              approve_pr = {
                lhs = "<leader>gpa";
                desc = "approve PR";
              };

              # reviews (gr)
              review_start = {
                lhs = "<leader>grr";
                desc = "start a review for the current PR";
              };
              review_resume = {
                lhs = "<leader>grR";
                desc = "resume a pending review for the current PR";
              };
              resolve_thread = {
                lhs = "<leader>grt";
                desc = "resolve PR thread";
              };
              unresolve_thread = {
                lhs = "<leader>grT";
                desc = "unresolve PR thread";
              };
              approve_review = {
                lhs = "<C-a>";
                desc = "approve review";
              };
              comment_review = {
                lhs = "<C-m>";
                desc = "comment review";
              };
              request_changes = {
                lhs = "<C-r>";
                desc = "request changes review";
              };
              submit_review = {
                lhs = "<leader>grs";
                desc = "submit review";
              };
              discard_review = {
                lhs = "<leader>grD";
                desc = "discard review";
              };
              add_review_comment = {
                lhs = "<leader>gra";
                desc = "add a new review comment";
              };
              add_review_suggestion = {
                lhs = "<leader>grA";
                desc = "add a new review suggestion";
              };
              review_commits = {
                lhs = "<leader>grC";
                desc = "review PR commits";
              };

              # navigation
              select_next_entry = {
                lhs = "]q";
                desc = "move to next changed file";
              };
              select_prev_entry = {
                lhs = "[q";
                desc = "move to previous changed file";
              };
              select_first_entry = {
                lhs = "[Q";
                desc = "move to first changed file";
              };
              select_last_entry = {
                lhs = "]Q";
                desc = "move to last changed file";
              };
              select_next_unviewed_entry = {
                lhs = "]u";
                desc = "move to next unviewed file";
              };
              select_prev_unviewed_entry = {
                lhs = "[u";
                desc = "move to previous unviewed file";
              };
              next_entry = {
                lhs = "j";
                desc = "move to next changed file";
              };
              prev_entry = {
                lhs = "k";
                desc = "move to previous changed file";
              };
              select_entry = {
                lhs = "<cr>";
                desc = "show selected changed file diffs";
              };
              next_thread = {
                lhs = "]t";
                desc = "move to next thread";
              };
              prev_thread = {
                lhs = "[t";
                desc = "move to previous thread";
              };
              focus_files = {
                lhs = "<leader>E";
                desc = "move focus to changed file panel";
              };
              toggle_files = {
                lhs = "<leader>te";
                desc = "hide/show changed files panel";
              };
              toggle_viewed = {
                lhs = "<leader><CR>";
                desc = "toggle viewer viewed state";
              };
              refresh_files = {
                lhs = "R";
                desc = "refresh changed files panel";
              };
              close_review_tab = {
                lhs = "<C-c>";
                desc = "close review tab";
              };
              goto_file = {
                lhs = "gf";
                desc = "go to file";
              };

              # labels (gl)
              create_label = {
                lhs = "<leader>glc";
                desc = "create label";
              };
              add_label = {
                lhs = "<leader>gli";
                desc = "add label";
              };
              remove_label = {
                lhs = "<leader>glx";
                desc = "remove label";
              };

              # assignees (ga)
              add_assignee = {
                lhs = "<leader>gai";
                desc = "add assignee";
              };
              remove_assignee = {
                lhs = "<leader>gax";
                desc = "remove assignee";
              };

              # notifications (gn)
              read = {
                lhs = "<leader>gnr";
                desc = "mark notification as read";
              };
              done = {
                lhs = "<leader>gnd";
                desc = "mark notification as done";
              };
              unsubscribe = {
                lhs = "<leader>gnu";
                desc = "unsubscribe from notifications";
              };

              # repo
              repo_options = {
                lhs = "<CR>";
                desc = "show repo options";
              };

              # shared
              reload = {
                lhs = "<C-r>";
                desc = "reload issue";
              };
              open_in_browser = {
                lhs = "<leader>gO";
                desc = "open issue in browser";
              };
              copy_url = {
                lhs = "<leader>giy";
                desc = "copy url to system clipboard";
              };
              copy_sha = {
                lhs = "<C-e>";
                desc = "copy commit SHA to system clipboard";
              };

              reaction_mappings = {
                inherit
                  react_hooray
                  react_heart
                  react_eyes
                  react_thumbs_up
                  react_thumbs_down
                  react_rocket
                  react_laugh
                  react_confused
                  ;
              };
            in
            {
              discussion = {
                inherit
                  discussion_options
                  add_comment
                  add_reply
                  delete_comment
                  next_comment
                  prev_comment
                  ;
              }
              // reaction_mappings;
              issue = {
                inherit
                  issue_options
                  close_issue
                  reopen_issue
                  reload
                  open_in_browser
                  copy_url
                  add_assignee
                  remove_assignee
                  create_label
                  add_label
                  remove_label
                  goto_issue
                  add_comment
                  add_reply
                  delete_comment
                  comment_edits
                  reference_in_new_issue
                  next_comment
                  prev_comment
                  ;
              }
              // reaction_mappings;
              pull_request = {
                inherit
                  pr_options
                  checkout_pr
                  merge_pr
                  squash_and_merge_pr
                  rebase_and_merge_pr
                  merge_pr_queue
                  squash_and_merge_queue
                  rebase_and_merge_queue
                  list_commits
                  list_changed_files
                  show_pr_diff
                  add_reviewer
                  remove_reviewer
                  close_issue
                  reopen_issue
                  list_issues
                  reload
                  approve_pr
                  open_in_browser
                  copy_url
                  copy_sha
                  goto_file
                  add_assignee
                  remove_assignee
                  create_label
                  add_label
                  remove_label
                  goto_issue
                  add_comment
                  add_reply
                  delete_comment
                  comment_edits
                  reference_in_new_issue
                  next_comment
                  prev_comment
                  review_start
                  review_resume
                  resolve_thread
                  unresolve_thread
                  ;
              }
              // reaction_mappings;
              review_thread = {
                inherit
                  goto_issue
                  add_comment
                  add_reply
                  add_suggestion
                  delete_comment
                  comment_edits
                  reference_in_new_issue
                  next_comment
                  prev_comment
                  select_next_entry
                  select_prev_entry
                  select_first_entry
                  select_last_entry
                  select_next_unviewed_entry
                  select_prev_unviewed_entry
                  close_review_tab
                  resolve_thread
                  unresolve_thread
                  ;
              }
              // reaction_mappings;
              submit_win = {
                inherit
                  approve_review
                  comment_review
                  request_changes
                  close_review_tab
                  ;
              };
              review_diff = {
                inherit
                  submit_review
                  discard_review
                  add_review_comment
                  add_review_suggestion
                  focus_files
                  toggle_files
                  next_thread
                  prev_thread
                  select_next_entry
                  select_prev_entry
                  select_first_entry
                  select_last_entry
                  select_next_unviewed_entry
                  select_prev_unviewed_entry
                  close_review_tab
                  toggle_viewed
                  goto_file
                  copy_sha
                  review_commits
                  ;
              };
              file_panel = {
                inherit
                  submit_review
                  discard_review
                  next_entry
                  prev_entry
                  select_entry
                  refresh_files
                  focus_files
                  toggle_files
                  select_next_entry
                  select_prev_entry
                  select_first_entry
                  select_last_entry
                  select_next_unviewed_entry
                  select_prev_unviewed_entry
                  close_review_tab
                  toggle_viewed
                  review_commits
                  ;
              };
              notification = {
                inherit
                  read
                  done
                  unsubscribe
                  ;
              };
              repo = {
                inherit
                  repo_options
                  create_issue
                  open_in_browser
                  ;
              };
              release = {
                inherit open_in_browser;
              };
            };
        };

        which-key.settings.spec = [
          {
            __unkeyed-1 = "<leader>gc";
            mode = "n";
            group = "+comments";
          }
          {
            __unkeyed-1 = "<leader>gcr";
            mode = "n";
            group = "+reactions";
          }
          {
            __unkeyed-1 = "<leader>gi";
            mode = "n";
            group = "+issues";
          }
          {
            __unkeyed-1 = "<leader>ga";
            mode = "n";
            group = "+assignees";
          }
          {
            __unkeyed-1 = "<leader>gl";
            mode = "n";
            group = "+labels";
          }
          {
            __unkeyed-1 = "<leader>gp";
            mode = "n";
            group = "+pull request";
          }
          {
            __unkeyed-1 = "<leader>gpm";
            mode = "n";
            group = "+merge";
          }
          {
            __unkeyed-1 = "<leader>gpmq";
            mode = "n";
            group = "+merge queue";
          }
          {
            __unkeyed-1 = "<leader>gpr";
            mode = "n";
            group = "+reviewers";
          }
          {
            __unkeyed-1 = "<leader>gr";
            mode = "n";
            group = "+review";
          }
          {
            __unkeyed-1 = "<leader>gn";
            mode = "n";
            group = "+notifications";
          }
        ];
      };
    };
  };
}
