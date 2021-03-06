#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: python

inputs:
  tarms: string
  templatedir: string
  prefactor: string
  workdir: string
  res2: string

arguments:
 - prefix: -c
   valueFrom: |
    import re
    import os
    import json
    subindir = "$(inputs.workdir)" + "/prefactor_output"
    SUB_MAP = {'^! data_input_path.+': '! data_input_path = ' + subindir + "/Pre-Facet-Target/results",
               '^! data_input_pattern.+': '! data_input_pattern = L' + "$(inputs.tarms)" + '*.pre-cal.ms',
               '^! prefactor_directory.+': '! prefactor_directory = $(inputs.prefactor)',
               '^! wsclean_executable.+': '! wsclean_executable = /opt/lofar/wsclean/bin/wsclean',
               '^! max_dppp_threads.+': '! max_dppp_threads = 2',
               '^! nbands_image.+': '! nbands_image = 4'
    }
    psfile = "Initial-Subtract.parset"
    srcfile = "$(inputs.templatedir)" + "/" + psfile
    dstfile = "$(inputs.workdir)" + "/" + psfile
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


