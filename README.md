# Inverse Kinematics using FABRIK

## Testing Platform
Operating System: Windows 10 Pro 64-bit, version 2004<br>
GPU: NVIDIA GeForce GTX 1080<br>
CPU: Intel Core i7 8700k<br>

## How To Run
1. Install Processing, can be found here https://processing.org/download/
2. Open the main file (InverseKinematics in the IK folder or ForwardKinematics in the FK folder)
3. This should open processing for you. From there you can just press the run button at the top<br>

### Macros
**You can drag around the red end effector by holding LMB on it**<br><br>
**d**: demo mode (default)<br>
&nbsp;&nbsp;&nbsp;&nbsp;**spacebar**: move through steps<br>
**n**: normal mode, simple FABRIK IK demonstration without any quirks<br>
**c**: constraint mode, semi working FABRIK with constraint of 75 degrees<br>
**g**: generate mode, you can generate your own FABRIK chains<br>
&nbsp;&nbsp;&nbsp;&nbsp;**LMB**: place your FABRIK joints<br>
&nbsp;&nbsp;&nbsp;&nbsp;**ENTER**: save your points and create chain<br>
&nbsp;&nbsp;&nbsp;&nbsp;**w**: wipe the points you created<br>
**b**: branch mode, FABRIK chains branching off from each other<br>
**f**: follow mode, if the end effector gets too far away, the chain will follow it<br>
&nbsp;&nbsp;&nbsp;&nbsp;**t**: tent/ribbon demo of follow mode<br>
**m**: cool demo of something I saw in a video game. circles follow you, but run away when you get too close<br>
**p**: pong mode, implementation of pong game using IK<br><br>

## Purpose
This is my project for COMP 4490 (Computer Graphics 2) on Inverse Kinematics using the FABRIK method. The program is meant for simple demonstrations of the main concepts with a few things I implemented for fun.
