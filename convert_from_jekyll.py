#!/usr/bin/env python3
from dataclasses import dataclass
from functools import cache
import os
import pathlib
import xml.etree.ElementTree as ET
import yaml  # from: pip install pyyaml


@dataclass
class Conversion:
    src: str
    dst: str
    permalink: str
    date: str


def mkdir_p(path):
    pathlib.Path(os.path.dirname(path)).mkdir(parents=True, exist_ok=True)


@cache
def files_in_src():
    fs = []
    for root, _, files in os.walk(os.getcwd()):
        for file in files:
            fs.append(os.path.join(root, file))
    return fs


def file_for_prefix(prefix):
    for path in files_in_src():
        base = os.path.basename(path)
        if base.startswith(prefix):
            return path
    raise ArgumentError(f"failed to find file for `{prefix}`")


def dst_for(dstdir, src, date, year):
    basedst = os.path.basename(src)#.replace(f"{date}-", "")
    if basedst.endswith(".markdown"):
        basedst = basedst.replace(".markdown", ".md")
    return os.path.join(dstdir, year, basedst)


def conversion_for(url, dstdir):
    permalink = url.replace("http://cbcg.net", "")
    _, _, year, month, day, name, _ = permalink.split("/")
    date = "-".join([year, month, day])
    src = file_for_prefix("-".join([year, month, day, name]))
    dst = dst_for(dstdir, src, date, year)
    return Conversion(src=src, dst=dst, permalink=permalink, date=date)


def conversions_from_sitemap(sitemap, dstdir):
    conversions = []
    for loc in ET.parse(sitemap).getroot().findall("./url/loc"):
        url = loc.text.strip()
        if "/blog/20" in url:
            conversions.append(conversion_for(url, dstdir))
    return conversions


def convert(conversion):
    print(f"Converting {conversion.src} ...")
    with open(conversion.src) as f:
        contents = f.readlines()
    in_header, header_lines, body_start = False, [], 0
    for line in contents:
        body_start += 1
        if line.strip() == "---":
            if in_header:
                break
            in_header = True
        elif in_header:
            header_lines.append(line)
    if len(header_lines) < 1:
        raise ArgumentError(f"found no header in `{conversion.src}`")
    hdr = yaml.safe_load("".join(header_lines))
    hdr["layout"] = "post"
    hdr["date"] = conversion.date
    hdr["permalink"] = conversion.permalink
    header = yaml.dump(hdr)
    body = "".join(contents[body_start:])
    whole = "".join(["---\n", header, "---\n", body])
    mkdir_p(conversion.dst)
    with open(conversion.dst, "w") as f:
        f.write(whole)


def main(args):
    sitemap, dstdir = args
    for conversion in conversions_from_sitemap(sitemap, dstdir):
        convert(conversion)


if __name__ == "__main__":
    import sys

    main(sys.argv[1:])

