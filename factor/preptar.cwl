#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: python

inputs:
  obs: string
  dpath: string
  ppath: string
  wpath: string
  res1: string

arguments:
 - prefix: -c
   valueFrom: |
    import re
    import os
    import json
    TAR_MAP = {'^! target_input_path.+': '! target_input_path = $(inputs.dpath)'+ "/L$(inputs.obs)",
               '^! target_input_pattern.+': '! target_input_pattern = L' + "$(inputs.obs)" + '_SB*.MS',
               '^! prefactor_directory.+': '! prefactor_directory = $(inputs.ppath)',
               '^! losoto_directory.+': '! losoto_directory = /opt/lofar/losoto',
               '^! aoflagger.+': '! aoflagger = /opt/lofar/aoflagger/bin/aoflagger',
               '^! max_dppp_threads.+': '! max_dppp_threads = 10'
    }
    psfile = "Pre-Facet-Target.parset"
    srcfile = "$(inputs.ppath)" + "/" + psfile
    dstfile = "$(inputs.wpath)" + "/" + psfile
    with open(srcfile, "r") as reader:
        lines = reader.readlines()
    with open(dstfile, "w") as writer:
        for line in lines:
            mf = False
            for ptn in TAR_MAP:
                if re.search(ptn, line):
                    mf = True
                    writer.write(re.sub(ptn, TAR_MAP[ptn], line))
            if not mf:
                writer.write(line)
    with open("cwl.output.json", "w") as output:
        json.dump({"tar_parset": dstfile}, output)

outputs:
  tar_parset: string

