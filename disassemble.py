import os
import subprocess
import sys

import pexpect


def get_entry_point(elf_path):
    # Run readelf to get the entry point address
    try:
        result = subprocess.run(['readelf', '-e', elf_path], capture_output=True, text=True, check=True)
        output = result.stdout

        # Extract entry point address using regex
        for line in output.splitlines():
            if 'Entry point address' in line:
                entry_point = line.split()[-1]  # The last item should be the address
                return entry_point
        print("[-] Entry point address not found.")
        return None
    except subprocess.CalledProcessError as e:
        print(f"Error running readelf: {e}")
        return None

def gdb_tui_workflow(binary_path, entry_point):
    # Get terminal size
    terminal_width = os.get_terminal_size().columns
    terminal_height = os.get_terminal_size().lines

    # Set terminal environment variables (for width and height)
    env = os.environ.copy()
    env['COLUMNS'] = str(terminal_width)
    env['LINES'] = str(terminal_height)

    # Spawn GDB with the binary and pass the correct environment variables
    gdb = pexpect.spawn(f"gdb {binary_path}", env=env)

    gdb.setwinsize(terminal_height, terminal_width)

    # Wait for the GDB prompt
    gdb.expect("(gdb)")

    # Set GDB width (can be used as fallback if terminal environment variables don't work)
    gdb.sendline(f"set width {terminal_width}")

    # Enable TUI mode
    gdb.sendline("tui enable")

    # Show the assembly view
    gdb.sendline("layout asm")

    # Set the breakpoint at the entry point
    gdb.sendline(f"b *{entry_point}")

    # Run the program
    gdb.sendline("run")

    # show registers
    gdb.sendline("tui reg all")

    # make one instruction step
    gdb.sendline("ni")


    # Let GDB run until it hits the entry point (we may want to add a timeout or a break point)
    gdb.expect("(gdb)")

    # Keep interacting with GDB
    gdb.interact()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python gdb_automate.py <path_to_elf_file>")
    else:
        binary_path = sys.argv[1]
        entry_point = get_entry_point(binary_path)

        if entry_point:
            print(f"[+] Entry point: {entry_point}")
            gdb_tui_workflow(binary_path, entry_point)
        else:
            print("[-] Could not extract entry point. Exiting.")
