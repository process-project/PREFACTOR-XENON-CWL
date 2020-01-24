#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: ["/usr/bin/singularity", "exec", "-B", "/var/scratch/madougou/LOFAR/", "/var/scratch/madougou/LOFAR/factor/factor.sif", "genericpipeline.py", "-d", "-c", "/var/scratch/madougou/LOFAR/auto/pipeline.cfg", "/var/scratch/madougou/LOFAR/auto/Pre-Facet-Target.parset"]

stdout: out2.txt

inputs:
  out_parse1:
    type: string

outputs:
  out_file2:
    type: File
    streamable: true
    outputBinding:
      glob: out2.txt
