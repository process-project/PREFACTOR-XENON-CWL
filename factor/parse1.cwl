#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: python

inputs:
  calcal_out: File

arguments:
 - prefix: -c
   valueFrom: |
     import json
     job_status = ""
     with open("$(inputs.calcal_out.path)", "r") as out_File:
         lines = out_File.readlines()
         job_status = job_status + lines[-3].strip() + "\\n"
         job_status = job_status + lines[-2]
     with open("cwl.output.json", "w") as output:
         json.dump({"res1": job_status}, output)

outputs:
  res1: string
