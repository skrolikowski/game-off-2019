return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.5",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 25,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 5,
  nextobjectid = 16,
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
      data = "eJztjUsKwCAQxbQVbKVaP73/WX0nkFk4WOQFQpYxhpD/88AsNCr8G/yEFv7555//iSRYhb4Kf0JWY2GAftBT8X/AC96DOsX/jnQUsApp"
    },
    {
      type = "tilelayer",
      id = 3,
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
      data = "eJxjYBgFMCALxIpQLDcA9ssDsTIUKwyA/aNgFIyCUTAKBifAVT/Rq97CVT+N1lujYBSMAnIAAGHsAwc="
    },
    {
      type = "objectgroup",
      id = 2,
      name = "Buttons",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 2,
          name = "[S]tart",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 480,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "[C]redits",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 480,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "[Q]uit",
          type = "",
          shape = "rectangle",
          x = 97,
          y = 64,
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
      id = 4,
      name = "Text",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 6,
          name = "Made with Love2D",
          type = "",
          shape = "rectangle",
          x = 414.667,
          y = 684,
          width = 192,
          height = 33.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "white",
            ["Font"] = "sm"
          }
        },
        {
          id = 9,
          name = "by Shane Krolikowski",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 385.333,
          width = 224,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "gray",
            ["Font"] = "xs"
          }
        },
        {
          id = 10,
          name = "[S]tart",
          type = "",
          shape = "rectangle",
          x = 369.333,
          y = 496,
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
          id = 11,
          name = "[C]redits",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 496,
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
          id = 12,
          name = "[Q]uit",
          type = "",
          shape = "rectangle",
          x = 114.667,
          y = 80,
          width = 92,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "white",
            ["Font"] = "md"
          }
        },
        {
          id = 13,
          name = "Priests vs Monsters",
          type = "",
          shape = "rectangle",
          x = 368,
          y = 237.333,
          width = 286.667,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "xl"
          }
        },
        {
          id = 14,
          name = "A Tower Defense Game",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 352,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "gray",
            ["Font"] = "md"
          }
        }
      }
    }
  }
}
