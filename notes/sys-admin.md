# Documenting Sys-Admin Related Operations

## Crash Diagnostics
* `last -x | less`: Display the system shutdown entries and run level changes. Use to identify time of crashes/downs.
* `journalctl -p emerg..err`: Display logs, filtered by log levels of *error* or higher severity.
