#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: python

inputs:
  src: string
  outdir: string
  ppath: string
  wpath: string
arguments:
 - prefix: -c
   valueFrom: |
    import re
    import os
    import json
    CFG_MAP = {'^runtime_directory.+': 'runtime_directory = $(inputs.outdir)',
              '^working_directory.+': 'working_directory = $(inputs.outdir)',
               '<PREFACTOR_PATH>': "$(inputs.ppath)"
    }
    dstfile = "$(inputs.wpath)" + "/pipeline.cfg"
    srcfile = "$(inputs.src)"
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

