
<h1 align="center">QuanDocker: A docker container for quantum machine learning (QML) research.</h1>
      
<p align="center">
  <a href="#about">About</a> •
  <a href="#credits">Credits</a> •
  <a href="#installation">Installation</a> •  
  <a href="#examples">Examples</a> •  
  <a href="#author">Author</a> •  

</p>

<h1 align="center">    
  <img src="https://github.com/BoltzmannEntropy/QMLDocker/blob/main/resources/HXH.png?raw=true" width="50%"></a>  
</h1>
---

## About

In comparison to many specialists, I am relatively new to the field of quantum computing, having only begun my journey in 2019. 
My interest in the subject was sparked by its potential and the difficulty in understanding it. 
I was also frustrated by the amount of misinformation being reported in the media about vendor announcements. 
To gain a deeper understanding of the field, I decided to enroll in a graduate program (JHU) where I would combine my knowledge of AI with applied physics, quantum mechanics, and quantum computing. 
The need for this container arose from my desire to have a single environment for my QML work on all platforms. 

I encountered challenges when trying to install the deep learning library paddlepaddle and its quantum extension paddle-quantum on a Mac with the new M1 chip, but ultimately succeeded in creating an Ubuntu-based docker that works with both on the M1 chip.

<table>
<tr>
<td>

## What can it do for me? 

# Quantum computing libraries

<h1 align="center">    
  <img src="https://github.com/BoltzmannEntropy/QMLDocker/blob/main/resources/logo.png?raw=true" width="40%"></a>  
</h1>
 <div align='center'>
 <table>
    <th>Library</th> 
   <th><code>Version</code><br/></th>      
   <tr>          
     <td>Qiskit</td>
     <td>Latest</td> 
   </tr>
 </table>
 </div>


# Running

```bash
sol@mprox QMLDocker % ./run.sh  

=============
== PyTorch ==
=============

NVIDIA Release 21.07 (build 25165078)
PyTorch Version 1.10.0a0+ecc3718

Container image Copyright (c) 2021, NVIDIA CORPORATION.  All rights reserved.

Copyright (c) 2014-2021 Facebook Inc.
Copyright (c) 2011-2014 Idiap Research Institute (Ronan Collobert)
Copyright (c) 2012-2014 Deepmind Technologies    (Koray Kavukcuoglu)
Copyright (c) 2011-2012 NEC Laboratories America (Koray Kavukcuoglu)
Copyright (c) 2011-2013 NYU                      (Clement Farabet)
Copyright (c) 2006-2010 NEC Laboratories America (Ronan Collobert, Leon Bottou, Iain Melvin, Jason Weston)
Copyright (c) 2006      Idiap Research Institute (Samy Bengio)
Copyright (c) 2001-2004 Idiap Research Institute (Ronan Collobert, Samy Bengio, Johnny Mariethoz)
Copyright (c) 2015      Google Inc.
Copyright (c) 2015      Yangqing Jia
Copyright (c) 2013-2016 The Caffe contributors
All rights reserved.

NVIDIA Deep Learning Profiler (dlprof) Copyright (c) 2021, NVIDIA CORPORATION.  All rights reserved.

Various files include modifications (c) NVIDIA CORPORATION.  All rights reserved.

This container image and its contents are governed by the NVIDIA Deep Learning Container License.
By pulling and using the container, you accept the terms and conditions of this license:
https://developer.nvidia.com/ngc/nvidia-deep-learning-container-license

WARNING: The NVIDIA Driver was not detected.  GPU functionality will not be available.
   Use 'nvidia-docker run' to start this container; see
   https://github.com/NVIDIA/nvidia-docker/wiki/nvidia-docker .

ERROR: This container was built for CPUs supporting at least the AVX instruction set, but
       the CPU detected was , which does not report
       support for AVX.  An Illegal Instrution exception at runtime is likely to result.
       See https://en.wikipedia.org/wiki/Advanced_Vector_Extensions#CPUs_with_AVX .

NOTE: MOFED driver for multi-node communication was not detected.
      Multi-node communication performance may be reduced.

NOTE: The SHMEM allocation limit is set to the default of 64MB.  This may be
   insufficient for PyTorch.  NVIDIA recommends the use of the following flags:
   nvidia-docker run --ipc=host ...

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```

## Troubleshooting
```
The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8)

Add this snipped to your ~/.zshrc and ~/.bashrc. It allows you not to repeat the flag anytime you perform a docker run command:

# useful only for Mac OS Silicon M1, 
# still working but useless for the other platforms
docker() {
 if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
    /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
  else
     /usr/local/bin/docker "$@"
  fi
}
``` 

--platform linux/amd64


# GPU or CPU?  
If you want to test on a GPU you will have to edit ./docker:

GPU mode:
```cmake

```
CPU mode: 
```cmake

```
**Note**: Tested only on **Mac OSX** with the **M1 CHIP**. 


</td>
</tr>
</table>

## Examples

#### A Simple example, mainly for testing the integration. imports all the quantum libraries in Python.
```python

```

## Requirements:
* (Optional) NVIDIA CUDA 11.2. For the GPU versions of paddle-quantum etc.   
* 64 bit only.  

## Building using docker


## Contributing
Feel free to report issues during build or execution. We also welcome suggestions to improve the performance of this application.
 

## Citation
If you find the code or trained models useful, please consider citing:

```
@misc{QuanDocker,
  author={Kashani, Shlomo},
  title={QuanDocker2023},
  howpublished={\url{https://github.com/}},
  year={2020}
}
```

## Disclaimers
 - No liability. Feel free to submit bugs or fixes.
 - No tech support: this is merely a spare-time fun project for me.
 - Tested only on Mac OSX with the M1 chip. More OS and dev env support are welcomed.



## Third party licences:
- NVIDIA CUDA license https://docs.nvidia.com/cuda/eula/index.html
- PyTorch https://github.com/pytorch/pytorch/blob/master/LICENSE

# References

