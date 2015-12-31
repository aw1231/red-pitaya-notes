---
layout: page
title: Scanning system
permalink: /scanner/
---

Introduction
-----

This configuration may be useful for building a galvanometer controller for an optical scanner.

Hardware
-----

The system outputs the line scan signal to OUT1 and the raster scan signal to OUT2. The trigger and S&H pulses are available from the pins DIO0_N and DIO1_N on the E1 connector.

The basic blocks of the system are shown on the following diagram:

![Scanner]({{ "/img/scanner.png" | prepend: site.baseurl }})

The [projects/scanner](https://github.com/pavel-demin/red-pitaya-notes/tree/master/projects/scanner) directory contains one Tcl file [block_design.tcl](https://github.com/pavel-demin/red-pitaya-notes/blob/master/projects/scanner/block_design.tcl) that instantiates, configures and interconnects all the needed IP cores.

Software
-----

The [projects/scanner/server](https://github.com/pavel-demin/red-pitaya-notes/tree/master/projects/scanner/server) directory contains the source code of the TCP server ([scanner.c](https://github.com/pavel-demin/red-pitaya-notes/blob/master/projects/scanner/server/scanner.c)) that receives control commands and transmits the data to the control program running on a remote PC.

The [projects/scanner/client](https://github.com/pavel-demin/red-pitaya-notes/tree/master/projects/scanner/client) directory contains the source code of the control program ([scanner.py](https://github.com/pavel-demin/red-pitaya-notes/blob/master/projects/scanner/client/scanner.py)).

![Scanner client]({{ "/img/scanner-client.png" | prepend: site.baseurl }})

Getting started
-----

 - Requirements:
   - Computer running Ubuntu 14.04 or Debian 8.
   - Wired Ethernet connection between the computer and the Red Pitaya board.
 - Download customized [SD card image zip file](https://googledrive.com/host/0B-t5klOOymMNfmJ0bFQzTVNXQ3RtWm5SQ2NGTE1hRUlTd3V2emdSNzN6d0pYamNILW83Wmc/scanner/ecosystem-0.92-65-35575ed-scanner.zip).
 - Copy the content of the SD card image zip file to an SD card.
 - Insert the SD card in Red Pitaya and connect the power.
 - Install required Python libraries:
{% highlight bash %}
sudo apt-get install python3-dev python3-pip python3-numpy python3-pyqt5
sudo pip3 install matplotlib
{% endhighlight %}
 - Clone the source code repository:
{% highlight bash %}
git clone https://github.com/pavel-demin/red-pitaya-notes
{% endhighlight %}
 - Run the control program:
{% highlight bash %}
cd red-pitaya-notes/projects/scanner/client
python3 scanner.py
{% endhighlight %}
 - Type in the IP address of the Red Pitaya board and press Connect button.
 - Adjust trigger and S&H pulses and number of samples per pixel.
 - Press Scan button.

Building from source
-----

The installation of the development machine is described at [this link]({{ "/development-machine/" | prepend: site.baseurl }}).

The structure of the source code and of the development chain is described at [this link]({{ "/led-blinker/" | prepend: site.baseurl }}).

Setting up the Vivado environment:
{% highlight bash %}
source /opt/Xilinx/Vivado/2015.4/settings64.sh
source /opt/Xilinx/SDK/2015.4/settings64.sh
{% endhighlight %}

Cloning the source code repository:
{% highlight bash %}
git clone https://github.com/pavel-demin/red-pitaya-notes
cd red-pitaya-notes
{% endhighlight %}

Building `scanner.bit`:
{% highlight bash %}
make NAME=scanner tmp/scanner.bit
{% endhighlight %}

Building `scanner`:
{% highlight bash %}
arm-xilinx-linux-gnueabi-gcc projects/scanner/server/scanner.c -o scanner -lm -static
{% endhighlight %}

Building `boot.bin`, `devicetree.dtb` and `uImage`:
{% highlight bash %}
make NAME=red_pitaya_0_92 all
{% endhighlight %}

Building SD card image zip file:
{% highlight bash %}
source scripts/scanner-ecosystem.sh
{% endhighlight %}