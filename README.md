<h1 align="center">QuanDocker: A docker container for quantum machine learning (QML) research (work in progress).</h1>
      
<p align="center">
  <a href="#about">About</a> •
  <a href="#credits">Credits</a> •
  <a href="#installation">Installation</a> •  
  <a href="#examples">Examples</a> •  
  <a href="#author">Author</a> •  

</p>

<h1 align="center">    
  <img src="https://github.com/BoltzmannEntropy/QMLDocker/blob/main/resources/HXH.png?raw=true" width="30%"></a>  
</h1>

On telegram: https://t.me/BoltzmannQ 

## About
My curiosity in quantum computing was ignited by its capabilities and the complexity of understanding it, 
and I was disappointed by the amount of inaccurate information being reported in the media about vendor announcements. 
To gain a more comprehensive understanding of the field, I enrolled in a graduate program (JHU) where I could combine 
my knowledge of AI with applied physics, quantum mechanics, and quantum computing. I wanted to create a single environment
for my QML work on all platforms, which is why I needed this container. I faced challenges when trying to install the deep 
learning libraries Qiskit and paddle-quantum on a Mac with the new M1 chip, but eventually succeeded in creating an 
Ubuntu-based docker that works with both on the M1 chip. 

The docker also includes several QML repositories with numerous examples:
 - https://github.com/theerfan/Q/tree/master/QML%20Course (A QML course in qiskit)
 - https://github.com/PaddlePaddle/Quantum.git (A QML course in Paddle-quantum)
 - https://github.com/DavitKhach/quantum-algorithms-tutorials.git
 - https://github.com/mit-han-lab/torchquantum.git
 - https://github.com/walid-mk/VQE.git 
 - https://github.com/MyEntangled/Quantum-Autoencoders.git
 - 
# Quantum computing libraries, features etc 
<h1 align="center">    
  <img src="https://github.com/BoltzmannEntropy/QMLDocker/blob/main/resources/libs.png?raw=true" width="40%"></a>  
</h1>

 - Based on nvcr.io/nvidia/pytorch:21.07-py3
 - PyTorch 
 - PyTorchQuantum 
 - PennyLane 
 - Eigen3
 - Quantum++ and PyQPP
 - Qiskit
 - Cirq 
 - Paddlepaddle
 - Paddle-quantum 
 - Tequila 
 - Qualacs
 - onnxruntime
 - Full LaTeX distribution
 - A passord protected Jupyter (password is:"mk2==2km") 
 - An SSH key that is embedded into the docker (change it of you want to)
 - Home directory /home/qmuser 
 - C++ compiler + CMake 
# Building
<h1 align="center">    
  <img src="https://github.com/BoltzmannEntropy/QMLDocker/blob/main/resources/logo.png?raw=true" width="30%"></a>  
</h1>
```bash
docker build -t quantdoc docker
```

# Running
```bash
docker run  --platform linux/amd64 -it --env="DISPLAY" -p 8097:7842 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -e DISPLAY -e XAUTHORITY -v /Users/sol/dev/:/home/qmuser/sharedfolder  quantdoc:latest bash
```

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



## Mapping volumes
The `run.sh` command, maps an external volume to docker as in: `-v /Users/sol/dev/:/home/qmuser/sharedfolder`. You can change that to fit your OS.  
## Jupyter
Once you are logged in, run the following command. Jupyter will be available at http://localhost:8097/
```python
qmuser@442b8ee86057:~$ ./run_jupyter.sh
Detected 5 cpus
/usr/local/nvm/versions/node/v15.12.0/bin:/opt/conda/bin:/opt/cmake-3.14.6-Linux-x86_64/bin/:/usr/local/mpi/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/ucx/bin:/opt/tensorrt/bin
qmuser@442b8ee86057:~$ sshd: no hostkeys available -- exiting.
[I 19:45:11.140 NotebookApp] Writing notebook server cookie secret to /home/qmuser/.local/share/jupyter/runtime/notebook_cookie_secret
[I 19:45:13.719 NotebookApp] jupyter_tensorboard extension loaded.
[I 19:45:15.250 NotebookApp] JupyterLab extension loaded from /opt/conda/lib/python3.8/site-packages/jupyterlab
[I 19:45:15.250 NotebookApp] JupyterLab application directory is /opt/conda/share/jupyter/lab
[I 19:45:15.260 NotebookApp] [Jupytext Server Extension] NotebookApp.contents_manager_class is (a subclass of) jupytext.TextFileContentsManager already - OK
[I 19:45:15.260 NotebookApp] Serving notebooks from local directory: /home/qmuser
[I 19:45:15.260 NotebookApp] Jupyter Notebook 6.2.0 is running at:

```

## Testing 
Try https://github.com/PaddlePaddle/Quantum/blob/master/tutorials/machine_learning/QClassifier_EN.ipynb 

<h1 align="center">    
  <img src="https://github.com/BoltzmannEntropy/QMLDocker/blob/main/resources/test.png?raw=true" width="60%"></a>  
</h1>

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
See the examples in the sub-folders /home/qmluser/
```python
USER qmuser
WORKDIR /home/qmuser
RUN git clone https://github.com/PaddlePaddle/Quantum.git
RUN git clone https://github.com/theerfan/Q/
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

