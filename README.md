# CWL files for automatic UC2 pipeline execution
This repository contains a set of CWL files defining workflows allowing to run UC2 in an automated fashion. The UC2 analysis is defined as CWL workflow whose steps correspond to the actual LTA data reduction pipeline steps plus some extra steps to create the appropriate directory structure and adapt the configuration files to the context and the selected data.

The files are split into two sets, each corresponding to a way of running UC2 relatively to whether the tool actually controlling the CWL tasks (*cwl-runner*) is running inside or outside the container

## *cwl-runner* running from inside the container
Both IEE and Xenon-flow worlk in this mode.
For IEE, there is nothing to specify as the files in **iee-cwl** are already included into the Singularity container and the CWL workflow file is called appropriately from the runscript. 
For Xenon-flow however, one has to specify an initial CWL file, **uc2incontainer.cwl**, which will start the computations inside the container. Files within **iee-cwl** will be called appropriately.

## *cwl-runner* running outside the container
Only Xenon-flow works in this mode. Then, one has to use the workflow definition in **process-uc2.cwl**. The steps of this workflow are defined by CWL files in the **factor** directory. All files must be accessible to the xenon-flow server at the runtime. The paths to the step CWL files are defined relatively to the workflow file. Usually, both **process-uc2.cwl** and **factor** are found in the xenon-flow directory.
