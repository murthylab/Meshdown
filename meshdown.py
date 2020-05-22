import sys
from meshparty import trimesh_io

meshlist = sys.argv[1]
meshlist = list(map(int, meshlist.split(",")))

with open("datasource.txt", "r") as f:
    datasource = f.read().strip()

save_dir = "meshes"

trimesh_io.download_meshes(
        meshlist,
        save_dir,
        datasource,
        fmt="obj")