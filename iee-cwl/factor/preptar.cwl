#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: python

inputs:
  tarms: string
  datadir: string
  workdir: string
  res1: string

arguments:
 - prefix: -c
   valueFrom: |
    import re
    import os
    import json
    tardir = "$(inputs.datadir)" + "/data/L" + "$(inputs.tarms)"
    TAR_MAP = {'^! target_input_path.+': '! target_input_path = ' + tardir,
               '^! target_input_pattern.+': '! target_input_pattern = L' + "$(inputs.tarms)" + '_SB*.MS',
               '^! prefactor_directory.+': '! prefactor_directory = /opt/lofar/prefactor',
               '^! losoto_directory.+': '! losoto_directory = /opt/lofar/losoto',
               '^! aoflagger.+': '! aoflagger = /opt/lofar/aoflagger/bin/aoflagger',
               '^! max_dppp_threads.+': '! max_dppp_threads = 2'
    }
    psfile = "Pre-Facet-Target.parset"
    srcfile = "/opt/lofar/templates/" + psfile
    dstfile = "$(inputs.workdir)" + "/" + psfile
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

