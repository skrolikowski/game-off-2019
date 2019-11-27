return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 25,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 5,
  nextobjectid = 6,
  properties = {},
  tilesets = {
    {
      name = "ui_tiles",
      firstgid = 1,
      filename = "ui_tiles.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "tiles/ui_tiles.png",
      imagewidth = 256,
      imageheight = 256,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 64,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "UI Back",
      x = 0,
      y = 0,
      width = 32,
      height = 25,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAFjYBgFoyEweEOAB+g0ATIxLxW8JQw0Q4RMLDhqP8UhMBr+Izv98QFTkBCZmJ/i1DdqwGgIjIbAaAiMhgCtQgAA6qIKtw=="
    },
    {
      type = "tilelayer",
      id = 2,
      name = "UI Front",
      x = 0,
      y = 0,
      width = 32,
      height = 25,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAFjYBgFoyEwGgKjITAaAqMhMHhDQBboNEUolsPiTELyWLSQJCQPVK0MxQpYdBKSx6JlVGg0BEZDYDQERnQIAAAjFQIF"
    },
    {
      type = "objectgroup",
      id = 4,
      name = "Buttons",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "[Q]uit",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 416,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "[M]enu",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 416,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      id = 3,
      name = "Text",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "[M]enu",
          type = "",
          shape = "rectangle",
          x = 591.33,
          y = 431.755,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "white",
            ["Font"] = "md"
          }
        },
        {
          id = 2,
          name = "[Q]uit",
          type = "",
          shape = "rectangle",
          x = 336.179,
          y = 431.755,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "white",
            ["Font"] = "md"
          }
        },
        {
          id = 5,
          name = "Congratulations!",
          type = "",
          shape = "rectangle",
          x = 322.652,
          y = 223.085,
          width = 384,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "xl"
          }
        }
      }
    }
  }
}
