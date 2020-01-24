#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: ["/usr/bin/singularity", "exec", "-B", "/var/scratch/madougou/LOFAR/", "/var/scratch/madougou/LOFAR/factor/factor.sif", "genericpipeline.py", "-d", "-c", "/var/scratch/madougou/LOFAR/auto/pipeline.cfg", "/var/scratch/madougou/LOFAR/auto/Pre-Facet-Calibrator.parset"]

stdout: out.txt

inputs:
  ms_ready: File

outputs:
  out_file1:
    type: File
    streamable: true
    outputBinding:
      glob: out.txt
