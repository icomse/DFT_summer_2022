from ase.io import read, write
from ase.build import molecule, surface, add_adsorbate, add_vacuum, sort
from ase.visualize import view
import click


@click.command()
@click.help_option("--help", "-h")
@click.option(
    "--unit-cell",
    type=str,
    required=True,
    help="Unit cell coordinate file.",
    metavar="",
)
@click.option(
    "--nxy",
    type=int,
    required=True,
    nargs=2,
    help="Repeats along x and y.",
    metavar="",
)
@click.option(
    "--miller-indices",
    type=int,
    required=True,
    nargs=3,
    help="Miller indices used to cut the unit cell.",
    metavar="",
)
@click.option(
    "--slab-depth", type=int, required=True, help="Slab thickness.", metavar="",
)
@click.option(
    "--vacuum-depth", type=int, required=True, help="Depth of vacuum.", metavar="",
)
def create_slab(unit_cell, nxy, miller_indices, slab_depth, vacuum_depth):

    slab = surface(read(unit_cell), miller_indices, slab_depth, vacuum_depth)
    system = slab.repeat(list(nxy) + [1])
    system = sort(system, system.positions[:, 2])
    view(system)


create_slab()
