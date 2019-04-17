#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: python
inputs:
  parse1_out: string
  parse2_out: string
  imgtar_out: File

arguments:
 - prefix: -c
   valueFrom: |
     import json
     job_status = "$(inputs.parse1_out)"
     job_status = job_status + "$(inputs.parse2_out)"
     with open("$(inputs.imgtar_out.path)", "r") as out_File:
         lines = out_File.readlines()
         job_status = job_status + lines[-1]
     with open("cwl.output.json", "w") as output:
         json.dump({"res": job_status}, output)

outputs:
  res: string
