#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: ["/usr/bin/singularity", "exec", "-B", "/var/scratch/madougou/LOFAR/", "/var/scratch/madougou/LOFAR/factor/factor.sif", "genericpipeline.py", "-d", "-c", "/var/scratch/madougou/LOFAR/auto/pipeline.cfg", "/var/scratch/madougou/LOFAR/auto/Initial-Subtract.parset"]

stdout: out3.txt

inputs:
  out_parse2:
    type: string

outputs:
  out_file3:
    type: File
    streamable: true
    outputBinding:
      glob: out3.txt

