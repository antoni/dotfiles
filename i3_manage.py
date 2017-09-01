#!/usr/bin/env python3

# sudo pip3 install i3ipc

import argparse
import i3ipc
import sys
import time

# Sleep time between i3.command() calls [s]
SLEEP_TIME = 0.2


def sleep_for(secs):
    def decorator(func):
        def wrapper(*args, **kwargs):
            ret = func(*args, **kwargs)
            time.sleep(secs)
            return ret
        return wrapper
    return decorator


@sleep_for(SLEEP_TIME)
def i3cmd(i3conn, cmd_string):
    """
    Executes i3 command with a SLEEP_TIME sleep after the call
    """
    i3conn.command(cmd_string)


def switch_output_workspaces(i3, focused):
    """
    Switches workspaces between outputs (monitors)
    """
    outputs = [o.name for o in filter(lambda o: o.active, i3.get_outputs())]
    if len(outputs) != 2:
        raise ValueError('You don\'t have 2 outputs active!')
    o1, o2 = outputs[0], outputs[1]

    for t in i3.get_workspaces():
        print(t.name + " on: " + t.output)
        i3cmd(i3, 'workspace "' + t.name + '"')
        i3cmd(i3, 'move workspace to output ' +
              (o2 if t.output == o1 else o1))

    # Switch back to focused
    if focused != None:
        i3cmd(i3, 'workspace "' + focused.name + '"')


def move_all_to_output(i3, output):
    """
    Moves all workspaces to a given output (monitor)
    """
    for t in i3.get_workspaces():
        i3cmd(i3, 'workspace' + t.name)
        i3cmd(i3, 'move workspace to output' + output)


def move_all_to_primary(i3, focused, primary=True):
    """
    Moves all workspaces to the primary output (monitor)
    """
    # Get outputs
    outputs = i3.get_outputs()

    for output in filter(lambda o: o.active and o.primary == primary, outputs):
        move_all_to_output(i3, output.name)
        i3cmd(i3, 'workspace' + focused.name)
        break

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
    description='Move workspaces across different monitors')

    subparsers = parser.add_subparsers(dest='sub_command')

    parser_branch = subparsers.add_parser('primary',
            description='Moves all workspaces to the primary output (monitor)')
    parser_branch = subparsers.add_parser('secondary',
            description='Moves all workspaces to the secondary output (monitor)')
    parser_branch = subparsers.add_parser('switch',
            description='Switches workspaces between outputs (monitors)')

    if len(sys.argv) < 2:
        parser.print_help()
        exit(0)

    args = parser.parse_args()

    # Create the Connection object
    i3 = i3ipc.Connection()

    # Find focuces workspace
    focused = i3.get_tree().find_focused().workspace()

    if args.sub_command == 'primary':
        move_all_to_primary(i3, focused, True)
    elif args.sub_command == 'secondary':
        move_all_to_primary(i3, focused, False)
    elif args.sub_command == 'switch':
        switch_output_workspaces(i3, focused)
