#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["/usr/bin/singularity", "exec", "-B", "/var/scratch/madougou/LOFAR/", "/var/scratch/madougou/LOFAR/lofar.simg", "genericpipeline.py", "-d", "-c", "/var/scratch/madougou/LOFAR/pipeline.cfg", "/var/scratch/madougou/LOFAR/Pre-Facet-Calibrator.parset"]

stdout: out.txt

inputs: []

outputs:
  - id: output_file
    type: stdout