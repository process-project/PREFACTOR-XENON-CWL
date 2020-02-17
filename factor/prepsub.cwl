#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: python

inputs:
  obs: string
  outdir: string
  ppath: string
  wpath: string
  res2: string

arguments:
 - prefix: -c
   valueFrom: |
    import re
    import os
    import json
    SUB_MAP = {'^! data_input_path.+': '! data_input_path = $(inputs.outdir)'+ "/Pre-Facet-Target/results",
               '^! data_input_pattern.+': '! data_input_pattern = L' + "$(inputs.obs)" + '*.precal.ms',
               '^! prefactor_directory.+': '! prefactor_directory = $(inputs.ppath)',
               '^! wsclean_executable.+': '! wsclean_executable = /opt/lofar/wsclean/bin/wsclean'
    }
    psfile = "Initial-Subtract.parset"
    srcfile = "$(inputs.ppath)" + "/" + psfile
    dstfile = "$(inputs.wpath)" + "/" + psfile
    with open(srcfile, "r") as reader:
        lines = reader.readlines()
    with open(dstfile, "w") as writer:
        for line in lines:
            mf = False
            for ptn in SUB_MAP:
                if re.search(ptn, line):
                    mf = True
                    writer.write(re.sub(ptn, SUB_MAP[ptn], line))
            if not mf:
                writer.write(line)
    with open("cwl.output.json", "w") as output:
        json.dump({"sub_parset": dstfile}, output)

outputs:
  sub_parset: string


