/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nogroup";

static const char *colorname[NUMCOLS] = {
	[BG] =     "black",     /* background */
	[INIT] =   "#4f525c",   /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* time in seconds before the monitor shuts down */
static const int monitortime = 10;

/*
* Shapes:
* 0: square
* 1: circle
*/
static const int shape = 1;
/* size of square in px */
static const int shapesize = 50;
static const int shapegap = 35;

static const char *background_image = "/home/plky/.config/slock-1.6/img.jpg";
