#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: python
inputs:
  container_out: File

arguments:
 - prefix: -c
   valueFrom: |
     import json
     job_status = ""
     with open("$(inputs.container_out.path)", "r") as out_File:
         lines = out_File.readlines()
         job_status = job_status + lines[-3].strip() + "\\n"
         job_status = job_status + lines[-2]
     with open("cwl.output.json", "w") as output:
         json.dump({"res": job_status}, output)

outputs:
  res: string
