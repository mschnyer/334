Hi there! Welcome to a ~Line System~

Inspired by a combo of 2010 era Windows screen savers
and 1960s digital artworks of John Whitney,
this program uses parametric equations combined with random
variables generated based on window size. The colors of each Line
System are also random.

In order to plug this system into a Raspberry Pi and to
run at boot, 

1. Clone the Git Repo module1.
2. In your Raspberry Pi's terminal, enter the following code: sudo nano /home/student334/.bashrc
3. At the end of the bash file, append the following 2 lines: (note - your paths may look different)
     cd /home/student334/processing-4.3/
     ./processing-java --sketch=/home/student334/334/module1 --present
4. In your terminal, type in the following to test: 
     sudo reboot

The generative art should run on reboot!
