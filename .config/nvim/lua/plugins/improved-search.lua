return {
  'backdround/improved-search.nvim',
  keys = {
    { 'n', function() require('improved-search').stable_next()         end, mode={'n','x','o'} },
    { 'N', function() require('improved-search').stable_previous()     end, mode={'n','x','o'} },
    { '*', function() require('improved-search').current_word_strict() end, mode={'n'}         }, -- search without moving
    { '*', function() require('improved-search').in_place()            end, mode={'x'}         }, -- search selections
  },
}
