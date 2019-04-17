#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: ["/usr/bin/singularity", "exec", "-B", "/var/scratch/madougou/LOFAR/", "/var/scratch/madougou/LOFAR/lofar.simg", "genericpipeline.py", "/var/scratch/madougou/LOFAR/Pre-Facet-Target-L232875.parset", "-v", "-d", "-c", "/var/scratch/madougou/LOFAR/pipeline.cfg"]

stdout: out2.txt

inputs:
  out_parse1:
    type: string

outputs:
  out_file2:
    type: stdout
