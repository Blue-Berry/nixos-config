# Add your reusable common modules to this directory.
# These are shared between NixOS and home-manager configurations.
{
  # List your module files here
  styling = import ./styling;
  system = import ./system;
}
