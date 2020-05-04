#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: python

inputs:
  workdir: string
  cal_ready: File
  tar_ready: File
  dir_ready: File
arguments:
 - prefix: -c
   valueFrom: |
    import re
    import os
    import json
    outdir = "$(inputs.workdir)" + "/prefactor_output"
    CFG_MAP = {'^runtime_directory.+': 'runtime_directory = ' + outdir,
              '^working_directory.+': 'working_directory = ' + outdir
    }
    dstfile = "$(inputs.workdir)" + "/pipeline.cfg"
    srcfile = "/opt/lofar/templates/pipeline.cfg"
    with open(srcfile, "r") as reader:
        lines = reader.readlines()
    with open(dstfile, "w") as writer:
        for line in lines:
            mf = False
            for ptn in CFG_MAP:
                if re.search(ptn, line):
                    mf = True
                    writer.write(re.sub(ptn, CFG_MAP[ptn], line))
            if not mf:
                writer.write(line)
    with open("cwl.output.json", "w") as output:
        json.dump({"cfg_fname": dstfile}, output)

outputs:
  cfg_fname: string

