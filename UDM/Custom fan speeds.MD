# Custom fan speeds

Trick to configure fanspeeds manually. Tried this for a while when I was using protect. By default fan speeds were too high for my taste. Temps were under control even with slower fanspeed (less noise)

Links:
<br/>Source for custom values: [Reddit, Fan speed trick on UDMP not working on 1.9.0]
<br/>Check later: [Github, Ubiquiti ubnt-fan-speed]



## Default values on 8.5.2022 (version 1.11.4)
```bash
cat /sys/class/hwmon/hwmon0/device/pwm1_enable
1
cat /sys/class/hwmon/hwmon0/device/pwm2_enable
1
cat /sys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm
128
cat /sys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm
128
cat /sys/class/hwmon/hwmon0/device/temp1_auto_point1_temp
45000
cat /sys/class/hwmon/hwmon0/device/temp1_auto_point2_temp
77000
cat /sys/class/hwmon/hwmon0/device/temp2_auto_point1_temp
90000
cat /sys/class/hwmon/hwmon0/device/temp2_auto_point2_temp
122000
cat /sys/class/hwmon/hwmon0/device/temp3_auto_point1_temp
90000
cat /sys/class/hwmon/hwmon0/device/temp3_auto_point2_temp
122000
```
## Auto fan mode:
```bash
killall -9 S04ubnt-fan-speed ubnt-fan-speed
echo 2 >/sys/class/hwmon/hwmon0/device/pwm1_enable
echo 2 >/sys/class/hwmon/hwmon0/device/pwm2_enable
echo 0 >/sys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm
echo 30 >/sys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm
echo 40000 >/sys/class/hwmon/hwmon0/device/temp1_auto_point1_temp
echo 66670 >/sys/class/hwmon/hwmon0/device/temp1_auto_point2_temp
echo 40000 >/sys/class/hwmon/hwmon0/device/temp2_auto_point1_temp
echo 66670 >/sys/class/hwmon/hwmon0/device/temp2_auto_point2_temp
echo 40000 >/sys/class/hwmon/hwmon0/device/temp3_auto_point1_temp
echo 66670 >/sys/class/hwmon/hwmon0/device/temp3_auto_point2_temp
```

## For manual fan mode (this example sets the fans to minimum/off)

```bash
killall -9 S04ubnt-fan-speed ubnt-fan-speed
echo 1 >/sys/class/hwmon/hwmon0/device/pwm1_enable
echo 1 >/sys/class/hwmon/hwmon0/device/pwm2_enable
echo 0 >/sys/class/hwmon/hwmon0/device/pwm1
echo 0 >/sys/class/hwmon/hwmon0/device/pwm2
```

### If you want to restore the Ubiquiti fan control because you're having problems

```bash
/etc/init.d/S04ubnt-fan-speed start
```

## Copy & paste from reddit post
<br />

>Of course you'll need to tweak the parameters (fan speed) to your liking. >The thread has more information on what each parameter is or [look at this]
>interface description for more details. But basically:
>
>For auto mode:
>
>pwm1* is the HDD fan, and pwm2* is the CPU fan.
>
>pwmX_auto_point1_pwm is the duty cycle (range 0 -> 255, e.g.: 127 means 50% >duty cycle).
>
>tempX_auto_point1/2_temp is the min/max temperature to apply the duty cycle >at (40000 means 40 C, 60000 means 60 C, etc...)
>
>For manual mode:
>
>pwmX is the manual value for fan (between 0 -> 255). Set to 0 for minimum >fan or off, 255 for max fan. Again, pwm1 is the HDD fan, and pwm2 is the >CPU fan.
>
>This also worked on boot when I put the script into an on boot script.



[arbitrary case-insensitive reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: http://www.reddit.com

[Reddit, Fan speed trick on UDMP not working on 1.9.0]: https://www.reddit.com/r/Ubiquiti/comments/lw4mjl/fan_speed_trick_on_udmp_not_working_on_190/
[Github, Ubiquiti ubnt-fan-speed]:https://github.com/heXeo/ubnt-fan-speed
[look at this]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/Documentation/hwmon/adt7475?id=1c301fc5394f7e1aa4c201e6e03d55d9c08b3bdf
