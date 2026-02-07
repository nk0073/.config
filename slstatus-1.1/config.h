/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 900;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

/*
 * function            description                     argument (example)
 *
 * battery_perc        battery percentage              battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * battery_remaining   battery remaining HH:MM         battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * battery_state       battery charging state          battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * cat                 read arbitrary file             path
 * cpu_freq            cpu frequency in MHz            NULL
 * cpu_perc            cpu usage in percent            NULL
 * datetime            date and time                   format string (%F %T)
 * disk_free           free disk space in GB           mountpoint path (/)
 * disk_perc           disk usage in percent           mountpoint path (/)
 * disk_total          total disk space in GB          mountpoint path (/)
 * disk_used           used disk space in GB           mountpoint path (/)
 * entropy             available entropy               NULL
 * gid                 GID of current user             NULL
 * hostname            hostname                        NULL
 * ipv4                IPv4 address                    interface name (eth0)
 * ipv6                IPv6 address                    interface name (eth0)
 * kernel_release      `uname -r`                      NULL
 * keyboard_indicators caps/num lock indicators        format string (c?n?)
 *                                                     see keyboard_indicators.c
 * keymap              layout (variant) of current     NULL
 *                     keymap
 * load_avg            load average                    NULL
 * netspeed_rx         receive network speed           interface name (wlan0)
 * netspeed_tx         transfer network speed          interface name (wlan0)
 * num_files           number of files in a directory  path
 *                                                     (/home/foo/Inbox/cur)
 * ram_free            free memory in GB               NULL
 * ram_perc            memory usage in percent         NULL
 * ram_total           total memory size in GB         NULL
 * ram_used            used memory in GB               NULL
 * run_command         custom shell command            command (echo foo)
 * swap_free           free swap in GB                 NULL
 * swap_perc           swap usage in percent           NULL
 * swap_total          total swap size in GB           NULL
 * swap_used           used swap in GB                 NULL
 * temp                temperature in degree celsius   sensor file
 *                                                     (/sys/class/thermal/...)
 *                                                     NULL on OpenBSD
 *                                                     thermal zone on FreeBSD
 *                                                     (tz0, tz1, etc.)
 * uid                 UID of current user             NULL
 * up                  interface is running            interface name (eth0)
 * uptime              system uptime                   NULL
 * username            username of current user        NULL
 * vol_perc            OSS/ALSA volume in percent      mixer file (/dev/mixer)
 *                                                     NULL on OpenBSD/FreeBSD
 * wifi_essid          WiFi ESSID                      interface name (wlan0)
 * wifi_perc           WiFi signal in percent          interface name (wlan0)
 */
static const char vol[] =
    "out=`wpctl get-volume @DEFAULT_SINK@`; "
    "muted=`printf \"%s\" \"$out\" | awk '{print $3}'`; "
    "v=`printf \"%s\" \"$out\" | awk '{print $2}'`; "
    "pct=`awk -v v=\"$v\" 'BEGIN{printf \"%d\", (v*100)+0.5}'`; "
    "if [ \"$muted\" = \"[MUTED]\" ] || [ \"$pct\" -le 0 ]; then "
        "printf \"󰝟 MUT\"; "
    "elif [ \"$pct\" -lt 34 ]; then "
        "printf \"󰕿 %s%%\" \"$pct\"; "
    "elif [ \"$pct\" -lt 67 ]; then "
        "printf \"󰖀 %s%%\" \"$pct\"; "
    "else "
        "printf \"󰕾 %s%%\" \"$pct\"; "
    "fi";

static const char bright[] =
    "b=`brightnessctl -m get 2>/dev/null`; "
    "max=`brightnessctl -m max 2>/dev/null`; "
    "pct=`awk -v b=\"$b\" -v m=\"$max\" 'BEGIN{ if(m>0) printf \"%d\", (b/m*100)+0.5; else print 0 }'`; "
    "if [ \"$pct\" -le 0 ]; then "
        "printf \"󰃞  %s%%\" \"$pct\"; "
    "elif [ \"$pct\" -lt 34 ]; then "
        "printf \"󰃟  %s%%\" \"$pct\"; "
    "else "
        "printf \"󰃠  %s%%\" \"$pct\"; "
    "fi";

static const char bt[] =
    "if ! command -v bluetoothctl >/dev/null 2>&1; then "
        "printf \"󰂯 N/A\"; exit; "
    "fi; "
    // removing timeout 0.1 is worse than death
    "powered=`timeout 0.1 bluetoothctl show 2>/dev/null | awk -F': ' '/Powered:/ {print $2}'`; "
    "if [ \"$powered\" != \"yes\" ]; then "
        "printf \"󰂯 OFF\"; exit; "
    "fi; "
    "dev=`bluetoothctl devices Connected 2>/dev/null | head -n1`; "
    "if [ -n \"$dev\" ]; then "
        "name=`printf \"%s\" \"$dev\" | cut -d' ' -f3-`; "
        "printf \"󰂱 %s\" \"$name\"; "
    "else "
        "printf \"󰂲 ON\"; "
    "fi";

static const struct arg args[] = {
	/*               function format   argument             */
	// { wifi_essid,    "%s ",            "wlp3s0"               },
	// { wifi_perc,     "%s%%",           "wlp3s0"               },
    // { run_command,   "| %s",           bright                 },
    { run_command,   "%s",           vol                    },
    // { run_command,   "| %s",           bt                     },
	// { battery_perc,  "|   %s%%",      "BAT0"                 },
	// { battery_state, "(%s) ",          "BAT0"                 },
	// { cpu_freq,      "|   %sHz",      NULL                   },
    { keymap,        "| %s ",           NULL                   },
	{ datetime,      "| %s",           "%A %I:%M %p - %m/%d"  },
};
