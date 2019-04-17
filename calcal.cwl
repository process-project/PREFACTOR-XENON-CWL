#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: ["/usr/bin/singularity", "exec", "-B", "/var/scratch/madougou/LOFAR/", "/var/scratch/madougou/LOFAR/lofar.simg", "genericpipeline.py", "/var/scratch/madougou/LOFAR/Pre-Facet-Calibrator-L232873.parset", "-d", "-c", "/var/scratch/madougou/LOFAR/pipeline.cfg"]

stdout: out.txt

inputs: []

outputs:
  out_file1:
    type: stdout
