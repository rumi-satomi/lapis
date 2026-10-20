/* 
  distancethreshold: Minimum cutoff for a gestures to take effect 
  degreesleniency: Offset degrees within which gesture is recognized (max=45)
  timeoutms: Maximum duration for a gesture to take place in miliseconds
  orientation: Number of 90 degree turns to shift gestures by
  verbose: 1=enabled, 0=disabled; helpful for debugging
  device: Path to the /dev/ filesystem device events should be read from
  gestures: Array of gestures; binds num of fingers / gesturetypes to commands
            Supported gestures: SwipeLR, SwipeRL, SwipeDU, SwipeUD,
                                SwipeDLUR, SwipeURDL, SwipeDRUL, SwipeULDR
*/

unsigned int distancethreshold = 50;
unsigned int degreesleniency = 20;
unsigned int timeoutms = 800;
unsigned int orientation = 0;
unsigned int verbose = 0;
char *device = "/dev/input/lisgd-touchscreen";

Gesture gestures[] = {
	/* nfingers  gesturetype  command */
	{ 1,         SwipeURDL,   "echo horizontal > /usr/local/etc/sway-mode && sway-sync-rotation && pkill -USR1 -q 0 lisgd" },
	{ 1,         SwipeULDR,   "echo vertical > /usr/local/etc/sway-mode && sway-sync-rotation && pkill -USR1 -q 3 lisgd" },
	{ 2,         SwipeLR,     "swaymsg workspace prev" },
	{ 2,         SwipeRL,     "swaymsg workspace next" },
	{ 2,         SwipeDU,     "pkill -SIGUSR2 wvkbd-lapis" },
	{ 2,         SwipeUD,     "pkill -SIGUSR1 wvkbd-lapis" },
};
