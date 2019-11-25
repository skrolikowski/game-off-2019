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
  nextlayerid = 7,
  nextobjectid = 38,
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
    },
    {
      name = "ui_entities",
      firstgid = 65,
      filename = "ui_entities.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "tiles/ui_entities.png",
      imagewidth = 128,
      imageheight = 128,
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
      tilecount = 16,
      tiles = {}
    },
    {
      name = "ui_icons",
      firstgid = 81,
      filename = "ui_icons.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "tiles/ui_icons.png",
      imagewidth = 512,
      imageheight = 384,
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
      tilecount = 192,
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
      data = "eAFjYBgFtAwBfaDhxmjYgJYWopltBuSromETNDW05BoCDTfFgmlpJzXM5gEaIkAlzEuGg4SBekSohAVH7Sc5BEbDfzT9jeY/6qSB0fKH5OKHYaSXP3zAIBOiEuYnPfhHddApBADyHBum"
    },
    {
      type = "tilelayer",
      id = 4,
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
      data = "eAHtkMsJgDAQRNOIP2zGBrT/Ugy4hxyG4V3VCSyE3cdk81rL+bqBc/jgNdxzjQFn4HDDmhEGxAQRBohbwojotIAB4pYw4KkgwgBxSxgRndaLDEx9161qNntTzkTI0dK7e9UqiadJORPxu9ENznUE8A=="
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
          id = 1,
          name = "[Q]uit",
          type = "",
          shape = "rectangle",
          x = 289,
          y = 673,
          width = 124,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "[M]enu",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 672,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "Volume Up",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Special"] = "volumeup"
          }
        },
        {
          id = 37,
          name = "Volume Down",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Special"] = "volumedown"
          }
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
          id = 4,
          name = "[Q]uit",
          type = "",
          shape = "rectangle",
          x = 303.667,
          y = 688.333,
          width = 94,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "white",
            ["Font"] = "md"
          }
        },
        {
          id = 6,
          name = "[M]enu",
          type = "",
          shape = "rectangle",
          x = 624,
          y = 688,
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
          id = 25,
          name = "Maps and User Interfaces",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 384,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs"
          }
        },
        {
          id = 24,
          name = "Tiled Map Editor",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 352,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 21,
          name = "Cursors, Fonts, SFX, and Menus",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 288,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs"
          }
        },
        {
          id = 11,
          name = "Kenney - kenney.nl",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 256,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 15,
          name = "Game State Manager / Timer",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 480,
          width = 254.666,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs"
          }
        },
        {
          id = 9,
          name = "hump",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 448,
          width = 254.667,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 20,
          name = "Entity Manager / Collision Detection",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 288,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs"
          }
        },
        {
          id = 7,
          name = "bump.lua",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 256,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 26,
          name = "Game framework for Lua",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 384,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs"
          }
        },
        {
          id = 27,
          name = "Love2D",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 352,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 28,
          name = "Pixel_Poem",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 448,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 29,
          name = "2D Pixel Dungeon Asset Pack",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 480,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs"
          }
        },
        {
          id = 30,
          name = "vitalzigns",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 544,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 31,
          name = "War Platformer Tileset",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 576,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs"
          }
        },
        {
          id = 32,
          name = "ansimuz",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 544,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 33,
          name = "Explosion Animations Pack",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 576,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs"
          }
        },
        {
          id = 34,
          name = "Thank You!!",
          type = "",
          shape = "rectangle",
          x = 381.333,
          y = 625.333,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "lg"
          }
        },
        {
          id = 35,
          name = "Volume",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 96,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        }
      }
    }
  }
}
