import os
import subprocess
from pathlib import Path
import shutil

ZIP = Path("msr3d.zip")
RAW = Path("msr3d-raw")
URL = "https://download.microsoft.com/download/6/F/B/6FBC4A82-443A-44F2-99F1-835F2C2E4379/3DVideos-distrib.zip"
RAW_BALLET = RAW / "MSR3DVideo-Ballet"
RAW_BREAKDANCERS = RAW / "MSR3DVideo-Breakdancers"
OUT_BALLET = Path("msr3d-ballet")
OUT_BREAKDANCERS = Path("msr3d-breakdancers")


def sh(cmd, *args, **kwargs):
    kwargs["check"] = True
    return subprocess.run(cmd, *args, **kwargs)


if __name__ == "__main__":
    if not os.path.exists(ZIP):
        sh(["curl", "-qo", ZIP, URL])

    if not os.path.exists(RAW):
        ZIP_INNER = "3DVideos-distrib"
        sh(["unzip", "-q", ZIP, "-d", RAW])
        shutil.copytree(RAW / ZIP_INNER, RAW, dirs_exist_ok=True)
        shutil.rmtree(RAW / ZIP_INNER)

    for scene, out in [(RAW_BREAKDANCERS, OUT_BREAKDANCERS), (RAW_BALLET, OUT_BALLET)]:
        os.makedirs(out / "images")
        for cam in scene.glob("cam*"):
            cam_num = int(cam.name.removeprefix("cam"))
            cam_id = f"cam{1+cam_num:02d}"
            for img in cam.glob("color-*.jpg"):
                img_num = int(img.stem.removeprefix(f"color-{cam.name}-f"))
                renamed = f"{cam_id}_{img_num:04d}{img.suffix}"
                shutil.copyfile(img, out / "images" / renamed)
