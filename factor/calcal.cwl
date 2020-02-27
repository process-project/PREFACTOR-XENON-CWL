#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

#baseCommand: ["/usr/bin/singularity", "exec", "-B", "/var/scratch/madougou/LOFAR/", "/var/scratch/madougou/LOFAR/factor/factor.sif", "genericpipeline.py", "-d", "-c", "/var/scratch/madougou/LOFAR/auto/pipeline.cfg", "/var/scratch/madougou/LOFAR/auto/Pre-Facet-Calibrator.parset"]

baseCommand: singularity
#baseCommand: echo
stdout: out.txt

inputs:
  pipecfg: string
  parset: string
  cimage: string
  shared: string
 
arguments: ["exec", "-B", "$(inputs.shared)", "$(inputs.cimage)", "genericpipeline.py", "-d", "-c", "$(inputs.pipecfg)", "$(inputs.parset)"]
#arguments: ["===Running calcal===\ncalcal successfully done\nCalcal completed."]

outputs:
  out_file1:
    type: File
    streamable: true
    outputBinding:
      glob: out.txt
