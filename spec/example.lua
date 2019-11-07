--
package.path = "../?.lua;" .. package.path
require 'busted.runner'()
require 'config'
--

describe('Tests', function()
    setup(function()
        -- run every test..
    end)

    it('it_should_', function()
        -- add assertions here..
    end)
end)