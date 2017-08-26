#!/usr/bin/env python3

# sudo pip3 install i3ipc

import i3ipc

# Switches workspaces between outputs (monitors)


def switch_output_workspaces(focused):
    outputs = [o.name for o in filter(lambda o: o.active, i3.get_outputs())]
    o1, o2 = outputs[0], outputs[1]

    for t in i3.get_workspaces():
        print(t.name + " on: " + t.output)
        i3.command('workspace "' + t.name + '"')
        i3.command('move workspace to output ' +
                   (o2 if t.output == o1 else o1))

    # Switch back to focused
    if focused != None:
        i3.command('workspace "' + focused.name + '"')

# Moves all workspaces to a given output (monitor)


def move_all_to_output(output):
    for t in i3.get_workspaces():
        i3.command('workspace' + t.name)
        i3.command('move workspace to output' + output)

# Moves all workspaces to the primary output (monitor)


def move_all_to_primary(focused):
    # Get outputs
    outputs = i3.get_outputs()

    for output in filter(lambda o: o.primary, outputs):
        move_all_to_output(output.name)
        i3.command('workspace' + focused.name)
        break

if __name__ == "__main__":
    # Create the Connection object
    i3 = i3ipc.Connection()

    # Find focuces workspace
    focused = i3.get_tree().find_focused().workspace()

    switch_output_workspaces(focused)
