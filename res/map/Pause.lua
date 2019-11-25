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
  nextlayerid = 6,
  nextobjectid = 41,
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
      name = "ui_icons",
      firstgid = 65,
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
    },
    {
      name = "ui_entities",
      firstgid = 257,
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
      data = "eJztzbsNACAMxNAMwDew/6xkAZpTKJBsyfUzI6JbJR7iNcFf8Raf+Pj4+Pj4n/otdvGe4NPbDjN2E1s="
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
      data = "eJxjYBgFo2AUjAL8YO9AOwAPYGSkvR3etLcCL/AhQS0zDcLDl/pGkgRc8Mix0iH+HWlvBdUADzA8+KgcJseoaxxVAScd4v8E7a3AC06SoJaLDuFBbyALxIpQLEeGPKVAHoiVoViBDPlRgB0AAINWBr8="
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
          id = 29,
          name = "[M]enu",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 672,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "[E]sc",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 672,
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
      id = 5,
      name = "Text",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 2,
          name = "Ranged Priest",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 320,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "gray",
            ["Font"] = "sm"
          }
        },
        {
          id = 3,
          name = "Trap Priest",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 352,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "gray",
            ["Font"] = "sm"
          }
        },
        {
          id = 4,
          name = "Heavy Priest",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 384,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "gray",
            ["Font"] = "sm"
          }
        },
        {
          id = 5,
          name = "Previous Priest",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 416,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "gray",
            ["Font"] = "sm"
          }
        },
        {
          id = 6,
          name = "Next Priest",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 448,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "gray",
            ["Font"] = "sm"
          }
        },
        {
          id = 7,
          name = "Keyboard",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 256,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 9,
          name = "Controls",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 224,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 11,
          name = "Mouse",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 512,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 12,
          name = "Action/Select",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 576,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "gray",
            ["Font"] = "sm"
          }
        },
        {
          id = 13,
          name = "Cycle Priests",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 608,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "gray",
            ["Font"] = "sm"
          }
        },
        {
          id = 14,
          name = "Characters",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 224,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 20,
          name = "Quick, insightful, steady, and wise.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 320,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "right",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 23,
          name = "Trap Priest",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 352,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "right",
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 24,
          name = "Sneaky, devious, enduring, and able.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 384,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 25,
          name = "Heavy Priest",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 416,
          width = 128,
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
          id = 27,
          name = "Ranged Priest",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 288,
          width = 128,
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
          id = 28,
          name = "Strong, determined, patient, and bold.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 448,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "right",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 31,
          name = "[M]enu",
          type = "",
          shape = "rectangle",
          x = 337.333,
          y = 688,
          width = 91,
          height = 30.6667,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "white",
            ["Font"] = "md"
          }
        },
        {
          id = 32,
          name = "Skeletons",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 480,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 33,
          name = "Skulls",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 544,
          width = 128,
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
          id = 34,
          name = "Vampires",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 608,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "right",
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 35,
          name = "Devious, determined, and unrelenting.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 512,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 36,
          name = "Tricky, quick, and numerous.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 576,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "right",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 37,
          name = "Wicked, strong, and dangerous.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 640,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 39,
          name = "[E]sc",
          type = "",
          shape = "rectangle",
          x = 592,
          y = 687,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "white",
            ["Font"] = "md"
          }
        }
      }
    }
  }
}
