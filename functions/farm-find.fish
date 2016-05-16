function farm-find --description 'Find repository'
    farm-ls | grep -- "$argv\$"
end
