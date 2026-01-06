{
  pkgs,
  lib,
  ...
}: {
  hj = {
    packages = [pkgs.lazygit];

    files = {
      ".config/lazygit/config.yml" = {
        generator = lib.generators.toYAML {};
        value = {
          gui = {
            scrollHeight = 10;
            scrollPastBottom = false;
            sidePanelWidth = 0.22;
            expandFocusedSidePanel = true;
            theme = {
              activeBorderColor = ["#e06c75" "bold"];
              inactiveBorderColor = ["#61afef"];
              searchingActiveBorderColor = ["#e06c75" "bold"];
              optionsTextColor = ["#82aaff"];
              selectedLineBgColor = ["#2a2a3a"];
              cherryPickedCommitFgColor = ["#82aaff"];
              cherryPickedCommitBgColor = ["#bd93f9"];
              markedBaseCommitFgColor = ["#82aaff"];
              markedBaseCommitBgColor = ["#e0c989"];
              unstagedChangesColor = ["#e06c75"];
              defaultFgColor = ["#cdd6f4"];
            };
            commitLength.show = true;
            branchColors = {
              release = "#e06c75";
              hotfix = "#e06c75";
              feature = "#85c87e";
            };
            showBottomLine = true;
            nerdFontsVersion = "3";
            showNumstatInFilesView = true;
            commandLogSize = 5;
            showDivergenceFromBaseBranch = "arrowAndNumber";
            filterMode = "fuzzy";
            showPanelJumps = false;
            skipRewordInEditorWarning = false;
            border = "rounded";
            statusPanelView = "allBranchesLog";
          };

          git = {
            paging = {
              colorArg = "always";
              pager = "delta --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
            };
            branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' {{branchName}} --";
            parseEmoji = true;
            allBranchesLogCmds = [
              "git log --graph --all --color=always --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
            ];
          };

          os = {
            editPreset = "nvim-remote";
          };

          disableStartupPopups = true;
          notARepository = "skip";
          promptToReturnFromSubprocess = false;

          keybinding = {
            universal = {
              quit = "q";
              quit-alt1 = "<c-c>";
              return = "<esc>";
              quitWithoutChangingDirectory = "Q";
              togglePanel = "<tab>";
              prevItem = "<up>";
              nextItem = "<down>";
              prevItem-alt = "k";
              nextItem-alt = "j";
              prevPage = "K";
              nextPage = "J";
              gotoTop = "<";
              gotoBottom = ">";
              scrollLeft = "H";
              scrollRight = "L";
              prevBlock = "<left>";
              nextBlock = "<right>";
              prevBlock-alt = "";
              nextBlock-alt = "";
              jumpToBlock = ["1" "2" "3" "4" "5"];
              nextMatch = "n";
              prevMatch = "N";
              optionMenu = "<disabled>";
              optionMenu-alt1 = "?";
              select = "<space>";
              goInto = "<enter>";
              openRecentRepos = "<c-r>";
              confirm = "<enter>";
              remove = "d";
              new = "n";
              edit = "e";
              openFile = "o";
              scrollUpMain = "<pgup>";
              scrollDownMain = "<pgdown>";
              scrollUpMain-alt1 = "<c-u>";
              scrollDownMain-alt1 = "<c-d>";
              scrollUpMain-alt2 = "<disabled>";
              scrollDownMain-alt2 = "<disabled>";
              executeShellCommand = ":";
              createRebaseOptionsMenu = "m";
              pushFiles = "P";
              pullFiles = "p";
              refresh = "R";
              createPatchOptionsMenu = "<c-p>";
              nextTab = "l";
              prevTab = "h";
              nextScreenMode = "+";
              prevScreenMode = "_";
              undo = "z";
              redo = "<c-z>";
              filteringMenu = "<c-s>";
              diffingMenu = "W";
              diffingMenu-alt = "<c-e>";
              copyToClipboard = "<c-o>";
              submitEditorText = "<enter>";
              extrasMenu = "@";
              toggleWhitespaceInDiffView = "<c-w>";
              increaseContextInDiffView = "}";
              decreaseContextInDiffView = "{";
            };

            status = {
              checkForUpdate = "u";
              recentRepos = "<enter>";
            };

            files = {
              commitChanges = "<c-c>";
              commitChangesWithoutHook = "w";
              amendLastCommit = "A";
              commitChangesWithEditor = "c";
              ignoreFile = "i";
              refreshFiles = "r";
              stashAllChanges = "s";
              viewStashOptions = "S";
              toggleStagedAll = "a";
              viewResetOptions = "D";
              fetch = "f";
              toggleTreeView = "`";
              openMergeOptions = "M";
              openStatusFilter = "<c-b>";
            };

            branches = {
              createPullRequest = "o";
              viewPullRequestOptions = "O";
              checkoutBranchByName = "c";
              forceCheckoutBranch = "F";
              rebaseBranch = "r";
              renameBranch = "R";
              mergeIntoCurrentBranch = "M";
              viewGitFlowOptions = "i";
              fastForward = "f";
              createTag = "T";
              pushTag = "P";
              setUpstream = "u";
              fetchRemote = "f";
            };

            commits = {
              squashDown = "s";
              renameCommit = "R";
              renameCommitWithEditor = "r";
              viewResetOptions = "g";
              markCommitAsFixup = "f";
              createFixupCommit = "F";
              squashAboveCommits = "S";
              moveDownCommit = "<c-j>";
              moveUpCommit = "<c-k>";
              amendToCommit = "A";
              pickCommit = "p";
              revertCommit = "t";
              pasteCommits = "v";
              tagCommit = "T";
              checkoutCommit = "<space>";
              resetCherryPick = "<c-R>";
              openLogMenu = "<c-l>";
              viewBisectOptions = "b";
            };

            stash = {
              popStash = "g";
              renameStash = "r";
            };

            commitFiles = {
              checkoutCommitFile = "c";
            };

            main = {
              toggleSelectHunk = "a";
              pickBothHunks = "b";
            };

            submodules = {
              init = "i";
              update = "u";
              bulkMenu = "b";
            };
          };

          customCommands = [
            {
              key = "<c-n>";
              description = "New branch with prefix";
              prompts = [
                {
                  type = "menu";
                  title = "Creating new branch. What kind of branch is it?";
                  options = [
                    {
                      name = "feature";
                      value = "feat";
                    }
                    {
                      name = "hotfix";
                      value = "hotfix";
                    }
                    {
                      name = "fix/bugfix";
                      value = "fix";
                    }
                    {
                      name = "chore";
                      value = "chore";
                    }
                    {
                      name = "experiment";
                      value = "experiment";
                    }
                  ];
                }
                {
                  type = "input";
                  title = "What is the new branch name?";
                  initialValue = "";
                }
              ];
              command = "git checkout -b {{index .PromptResponses 0}}/{{index .PromptResponses 1}}";
              context = "localBranches";
              loadingText = "Creating branch";
            }
            {
              key = "<c-r>";
              description = "Create pull request on GitHub";
              context = "files, localBranches";
              prompts = [
                {
                  type = "input";
                  title = "Pull Request Title";
                  key = "title";
                  initialValue = "";
                }
                {
                  type = "input";
                  title = "Base Branch (leave empty for default branch)";
                  key = "base";
                  initialValue = "";
                }
                {
                  type = "menu";
                  title = "Create as draft PR?";
                  key = "draft";
                  options = [
                    {
                      name = "No";
                      value = "";
                    }
                    {
                      name = "Yes";
                      value = "--draft";
                    }
                  ];
                }
                {
                  type = "menu";
                  title = "Add Reviewers";
                  key = "reviewers";
                  options = [
                    {
                      name = "CNS";
                      value = "--reviewer peterbornerup,farhadh,benjaminbruun";
                    }
                    {
                      name = "None";
                      value = "";
                    }
                  ];
                }
              ];
              command = ''
                gh pr create --assignee @me --title "{{.Form.title}}" --fill \
                {{ if ne .Form.base "" }}--base "{{.Form.base}}"{{ end }} \
                {{.Form.draft}} \
                {{ if eq .Form.reviewers "other" }}--reviewer "{{.Form.customReviewers}}"{{ else }}{{.Form.reviewers}}{{ end }}
              '';
              loadingText = "Creating pull request on GitHub";
            }
            {
              key = "o";
              command = "gh repo view --web";
              context = "localBranches";
              description = "View Repo on GitHub";
              loadingText = "Opening GitHub - Repository ...";
            }
            {
              key = "O";
              command = "gh pr view --web";
              context = "localBranches";
              description = "View PR on GitHub";
              loadingText = "Opening GitHub - Pull request ...";
            }
            {
              key = "C";
              context = "global";
              description = "Create new conventional commit";
              prompts = [
                {
                  type = "menu";
                  key = "Type";
                  title = "Type of change";
                  options = [
                    {
                      name = "✨ feat";
                      description = "A new feature";
                      value = "✨ feat";
                    }
                    {
                      name = "☣️ fix";
                      description = "A bug fix";
                      value = "☣️ fix";
                    }
                    {
                      name = "📝 docs";
                      description = "Documentation only changes";
                      value = "📝 docs";
                    }
                    {
                      name = "🎨 style";
                      description = "Non-functional formatting (e.g. spaces, semicolons)";
                      value = "🎨 style";
                    }
                    {
                      name = "♻️ refactor";
                      description = "Refactor without behavior change";
                      value = "♻️ refactor";
                    }
                    {
                      name = "🚀 update";
                      description = "Update flake and Configs";
                      value = "🚀 update";
                    }
                    {
                      name = "✅ test";
                      description = "Adding or correcting tests";
                      value = "✅ test";
                    }
                    {
                      name = "🔧 chore";
                      description = "Maintenance (configs, npins, etc.)";
                      value = "🔧 chore";
                    }
                    {
                      name = "📦 build";
                      description = "Build system or external dependency updates";
                      value = "📦 build";
                    }
                    {
                      name = "🤖 ci";
                      description = "Changes to CI/CD files";
                      value = "🤖 ci";
                    }
                    {
                      name = "⏪ revert";
                      description = "Revert a previous commit";
                      value = "⏪ revert";
                    }
                  ];
                }
                {
                  type = "input";
                  title = "Scope";
                  key = "Scope";
                  initialValue = "";
                }
                {
                  type = "menu";
                  key = "Breaking";
                  title = "Breaking change";
                  options = [
                    {
                      name = "no";
                      value = "";
                    }
                    {
                      name = "yes";
                      value = "!";
                    }
                  ];
                }
                {
                  type = "input";
                  title = "message";
                  key = "Message";
                  initialValue = "";
                }
                {
                  type = "confirm";
                  key = "Confirm";
                  title = "Commit";
                  body = "Are you sure you want to commit?";
                }
              ];
              command = "git commit --message '{{.Form.Type}}{{ if .Form.Scope }}({{ .Form.Scope }}){{ end }}{{.Form.Breaking}}: {{.Form.Message}}'";
              loadingText = "Creating conventional commit...";
            }
            {
              key = "R";
              command = "git reset --soft HEAD~1";
              context = "files";
              description = "Undo last commit";
            }
            {
              key = "a";
              context = "global";
              prompts = [
                {
                  type = "menu";
                  title = "Push to:";
                  options = [
                    {
                      name = "GitHub";
                      value = "git push origin HEAD";
                    }
                    {
                      name = "Codeberg";
                      value = "git push codeberg HEAD";
                    }
                  ];
                }
              ];
              command = "{{.Form.Value}}";
              loadingText = "Pushing...";
            }
          ];
        };
      };
    };
  };
}
