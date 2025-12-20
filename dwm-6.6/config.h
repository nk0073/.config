/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 10;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]    = { "CommitMono:size=17" };
static const char dmenufont[] = "CommitMono:size=17";
static const char col_foreground[]  = "#BCC4C9";
static const char col_foreground2[] = "#f78ade";
static const char col_background[]  = "#1A2023";
static const char col_background2[] = "#252B2E";
static const char col_sel_border[]  = "#dfdfd9";
static const char col_norm_border[] = "#182221";
static const char *colors[][3]      = {
	/*               fg               bg               border */
	[SchemeNorm] = { col_foreground2, col_background2, col_background2 },
	[SchemeSel]  = { col_foreground,  col_background,  col_sel_border  },
};

static const Gap default_gap =
{.isgap = 0, .realgap = 15, .gappx = 15};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
// 	/* xprop(1):
// 	 *	WM_CLASS(STRING) = instance, class
// 	 *	WM_NAME(STRING) = title
// 	 */
// 	/* class      instance    title       tags mask     isfloating   monitor   border*/
	{ "Firefox",  NULL,       NULL,       0,            0,           -1,        borderpx },
    { "honkers-railway-launcher", NULL, NULL, 0,        1,           -1 ,       borderpx },
    { "feh",      NULL,       NULL,       0,            1,           -1,        borderpx },
};

static const char *const autostart[] = {
    "xset", "-b",           NULL,
    "pipewire", NULL,
    "setxkbmap", "-layout", "us,ru", "-option", "grp:ctrls_toggle", NULL,
    // uhhh this works just for 1 of the screens so set 
    // the wallpaper in nitrogen gui (yuck) and then nitrogen --restore
    // "nitrogen", "--set-zoom-fill", "/home/plky/.config/wallpaper/kirino.png", "--head=0", NULL,
    // "nitrogen", "--set-zoom-fill", "/home/plky/.config/wallpaper/kirino_win7.png", "--head=1", NULL,
    "nitrogen", "--restore", NULL,
    "/home/plky/.config/dwmstat.sh", NULL,
    "redshift", "-l", "40.7:-74.0", "-t", "6500:3600", NULL,
    "xcompmgr", NULL,
    
    // screen blank/off after 1h 
    "xset", "s", "3600", "3600", NULL,
    "xset", "+dpms", NULL,
    "xset", "dpms", "3600", "3600", "3600", NULL,

    NULL
};


/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char* dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb",
    col_background2, "-nf", col_foreground2, "-sb", col_sel_border, "-sf", col_background,
    "-i",
    NULL };
static const char* termcmd[]  = { "st", NULL };
static const char* screenshot[] = { "flameshot", "gui", NULL };
static const char* screenshot_full[] = { "flameshot", "full", "--clipboard", NULL };
// static const char* screenshot[] = { "/home/plky/.config/screenshot.sh", NULL };

// media buttons
#include <X11/XF86keysym.h>
#include "movestack.c"
static const char *volup[]   = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%", NULL };
static const char *voldown[] = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%", NULL };
static const char *volmute[] = { "pactl", "set-sink-mute",   "@DEFAULT_SINK@", "toggle", NULL };
static const char *mplaypause[] = { "playerctl", "play-pause", NULL };
static const char *mnext[]      = { "playerctl", "next",       NULL };
static const char *mprev[]      = { "playerctl", "previous",   NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
    { MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
    { MODKEY,                       XK_f,      togglefullscr,  {0} },

    { 0, XF86XK_AudioRaiseVolume,              spawn,         { .v = volup } },
    { 0, XF86XK_AudioLowerVolume,              spawn,         { .v = voldown } },
    { 0, XF86XK_AudioMute,                     spawn,         { .v = volmute } },
    { 0, XF86XK_AudioPlay,                     spawn,         { .v = mplaypause } },
    { 0, XF86XK_AudioNext,                     spawn,         { .v = mnext } },
    { 0, XF86XK_AudioPrev,                     spawn,         { .v = mprev } },
    { 0,                            XK_Print,  spawn,         { .v = screenshot } },
    { MODKEY,                       XK_Print,  spawn,         { .v = screenshot_full } },
	{ MODKEY|ShiftMask,             XK_minus,  setgaps,        {.i = GAP_RESET } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = GAP_TOGGLE} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

