import std.stdio;
import std.string;

int main(string[] args){
  //paths of the files controling keyboard brightness
  enum brightness_path="/sys/class/leds/asus::kbd_backlight/brightness";
  enum max_brightness_path="/sys/class/leds/asus::kbd_backlight/max_brightness";

  immutable int max_brightness = get_max_brightness(max_brightness_path);

  if(args.length == 1){
    stderr.writeln("You must specify an option");
    stderr.writeln("Valids options are :\n\t- up : up the keyboard luminosity\n\t- down : down the keyboard luminosity\n\t- current : get the current luminosity");
    return 1;
  }

  switch(args[1]){
  case "up":
    up_brightness(brightness_path, max_brightness);
    break;
  case "down":
    down_brightness(brightness_path);
    break;
  case "current":
    writeln(get_brightness(brightness_path));
    break;
  default:
    stderr.writeln("Wrong option.");
    stderr.writeln("Valids options are :\n\t- up : up the keyboard luminosity\n\t- down : down the keyboard luminosity\n\t- current : get the current luminosity");
    return 1;
  }
  
  return 0;
}

/**
 * Returns the max brighness of the keyboard from the max_brightness file.
 * Params:
 *  path : path of the file
 * Returns:
 *  max : value of the max brightness
 */
int get_max_brightness(string path){
  int a;
  File max_brightness = File(path, "r");

  max_brightness.readf("%d", &a);
  max_brightness.close();
  return a;
}

/**
 * Returns the current brightness
 * Params:
 *  path : path of the brightness file
 * Returns:
 *  brightness: current brightness
 */
int get_brightness(string path){
  File brightness_file = File(path, "r");
  int brightness;
  brightness_file.readf("%d", &brightness);

  return brightness;
}

/**
 * Modify the brightness_path file to up the luminosity, if it isn't upon max_brightness
 * Params:
 *  path : path of brightness file path
 *  max_brightness : maximum brightness
 */
void up_brightness(string path, immutable int max_brightness){
  int brightness = get_brightness(path);

  if(brightness < max_brightness){
    File brightness_file = File(path, "w");
    brightness_file.write(brightness+1);
    brightness_file.close();
  }
}

/**
 * Modify the brightness_path file to down the luminosity, it isn't under 0.
 * Params:
 *  path : path of the brightness file path
 */
void down_brightness(string path){
  int brightness;
  brightness = get_brightness(path);
  
  if(brightness > 0){
    File brightness_file = File(path, "w");
    brightness_file.write(brightness-1);
    brightness_file.close();
  }
}
