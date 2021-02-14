import math
def filterTags(attrs):
    if not attrs:
        return
    tags = {}
    tags['highway'] = 'road' # TODO: clarify?
    # TODO: convert from mph/kph to kph
    to_lim = 0
    from_lim = 0
    if 'TO_SPD_LIM' in attrs:
        to_lim = int(attrs['TO_SPD_LIM'])
    if 'FR_SPD_LIM' in attrs:
        from_lim = int(attrs['FR_SPD_LIM'])
    if to_lim == 0 and from_lim == 0:
        return tags
    if to_lim == 0:
        to_lim = 9898
    elif from_lim == 0:
        from_lim = 9898
    if to_lim < from_lim:
        maxspeed = to_lim
    else:
        maxspeed = from_lim
    if maxspeed == 0 or maxspeed == 9898:
        print("BIG ERROR, MAXSPEED IS 0")
    else:
        tags['maxspeed'] = str(math.floor(maxspeed * 1.60934))
    return tags
