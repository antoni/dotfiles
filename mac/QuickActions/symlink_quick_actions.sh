#!/usr/bin/env  bash
#ln -sf ~/dotfiles/mac/QuickActions/Move\ to\ Documents.workflow ~/Library/Services/.
#ln -sf ~/dotfiles/mac/QuickActions/Move\ to\ Pictures.workflow ~/Library/Services/.

rm --recursive --force tmp_workflows
mkdir tmp_workflows
cp --recursive ./*workflow tmp_workflows/
open tmp_workflows

osascript -e 'display notification "To install workflow, open each .workflow file manually" with title "Workflows installation"'
