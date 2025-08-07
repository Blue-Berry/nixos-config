{ lib
, stdenv
, writeShellScriptBin
, git
, neovim
, coreutils
}:

writeShellScriptBin "git-commit-ai" ''
  set -euo pipefail

  # Check if we're in a git repository
  if ! ${git}/bin/git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
  fi

  # Check if there are any changes to commit
  if ${git}/bin/git diff --cached --quiet && ${git}/bin/git diff --quiet; then
    echo "No changes to commit"
    exit 0
  fi

  # Stage all changes
  ${git}/bin/git add .

  # Generate commit message using claude
  ${git}/bin/git diff --cached | claude -p "Generate a concise git commit message for these changes. Return only the commit message with no explanations, formatting, or extra text, use emojis when relevant. Add a body to the message with more details from the change." > /tmp/commit_msg.txt

  # Open the commit message in nvim for editing
  ${neovim}/bin/nvim /tmp/commit_msg.txt

  # Commit with the message from the file
  ${git}/bin/git commit -F /tmp/commit_msg.txt

  # Clean up the temporary file
  ${coreutils}/bin/rm /tmp/commit_msg.txt

  echo "Commit successful!"
''