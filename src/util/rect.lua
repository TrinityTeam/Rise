local Rect = {}

function Rect.inside(rect, point) 
    assert(rect.x and rect.y and rect.w and rect.h, "Invalid rect; Expected table {x, y, w, h}")
    assert(point.x and point.y, "Invalid point; Expected table {x, y}")

    if point.x >= rect.x and point.x <= rect.w + rect.x and
       point.y >= rect.y and point.y <= rect.y + rect.h then
       return true
    else
        return false
    end
end



return Rect