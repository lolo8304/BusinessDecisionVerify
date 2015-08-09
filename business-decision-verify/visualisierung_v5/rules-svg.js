/* create an svg drawing */

function drawRuleFamilyGraph() {
var draw = SVG('drawing')

var boxDiff = 20


/* draw rectangle */

//var symbol = draw.symbol()
var group = draw.nested()
var ruleSymbol = draw.defs()

var ruleDef = ruleSymbol.polygon("40,00 80,00 100,20 100,60 80,80 40,80 20,60 20,20 40,00").fill('#d3ffff').stroke({ color: '#6b98ab', width: 2 })

var familyDef = ruleSymbol.polygon("20,00 100,00 120,20 120,80 00,80 00,20 20,00")
    .fill('#d3fdda').stroke({ color: '#6b98ab', width: 2 })
var familyDef_box = familyDef.rbox()

var rule = group.use(ruleDef).move(50,0)
var rule_box = rule.rbox()

var familyGroup = group.group()
    .addClass('group-rule-family')
    .attr('id', 'group-rule-family-0')
    .attr('group-id', 'group-rule-family-0')
    .attr('parent-group-id', '')
    .attr('nof-kids', 0)
    .attr('total-nof-kids', 0)

var family = familyGroup.use(familyDef).move(
    rule_box.x+rule_box.w/2-familyDef_box.w/2, 
    rule_box.y2+boxDiff)
    .attr('id', 'rule-family-0')
    .attr('group-id', 'group-rule-family-0')
    .attr('parent-id', '')
    .attr('parent-group-id', '')
var family_box = family.rbox()
familyGroup.path('M'+(family_box.x+family_box.w/2)+" "+family_box.y+" v-"+boxDiff)
        .fill('none').stroke({ color: '#6b98ab', width: 3 })

group.dmove(300,50)

var childrenArray = addChildFamilies(family, 3)
var childrenArray1  = addChildFamilies(childrenArray[0], 2)
var childrenArray2  = addChildFamilies(childrenArray[1], 1)
var childrenArray3  = addChildFamilies(childrenArray[2], 1)
/*
var childrenArray11 = addChildFamilies(childrenArray1[0], 1)
var childrenArray12 = addChildFamilies(childrenArray1[1], 1)

var childrenArray21 = addChildFamilies(childrenArray2[0], 1)
var childrenArray22 = addChildFamilies(childrenArray2[1], 1)
*/
//group.move('25%', 20)

function selectClass (node, className) {
    var children = [];
    node.each(function(i) {
        if (this.hasClass(className)) {
            children.push(this)
        }
    })
    return children
}

function connectFamilies(group, parentFamily, childFamily) {
    var connectors = selectClass(group, 'rule-connector')
    var connector = connectors[0]
    var diffX = 0
    var max = maxLeftRight(group)
    if (connector) {
    	diffX = group.rbox().x - group.bbox().x
    }
    var pbox = parentFamily.rbox();
    var cbox = childFamily.rbox();
    var pathString = null
    var pathColor = null
    if (pbox.x > cbox.x) {
        pathString = 
            "M "+
            (pbox.x-diffX)+" "+
            (pbox.y + pbox.h/2)+" "+
            "h-"+(pbox.x - cbox.x - diffX - cbox.w/2)+" v "+(pbox.h/2+boxDiff)
        pathColor = '#FF0000'
    } else if (pbox.x < cbox.x) {
        pathString = 
            "M "+
            (pbox.x2-diffX)+" "+
            (pbox.y + pbox.h/2)+" "+
            "h"+(cbox.x - pbox.x + diffX - cbox.w/2)+" v "+(pbox.h/2+boxDiff)
        pathColor = '#000000'
    } else {
        pathString = 
            "M "+
            (pbox.x+pbox.w/2)+" "+
            pbox.y2+" "+
            " v "+(boxDiff)
        pathColor = '#6b98ab'
    }
    if (connector) {
        pathColor = '#008000'
        connector.plot(pathString)
    } else {
        connector = group.path(pathString)
    }
    connector.fill('none')
            .stroke({ color: pathColor, width: 3 })
            .addClass('rule-connector')
            .attr('parent-id', parentFamily.attr('id'))
            .attr('id', 'connector-'+childFamily.attr('id'))
}


function addChildFamilies(family, nof) {
    var children = []
    var group = family.parent()
    var bbox = family.rbox()
    var parentId = family.attr('id')
    var totalW = nof * (bbox.w +  boxDiff) - boxDiff
    var leftStart = bbox.x + bbox.w/2 - totalW / 2
    var topStart = bbox.y2 + boxDiff
    var i = 0
    while (i < nof) {
        var familyGroupNew = group.group()
            .addClass('group-rule-family')
            .attr('parent-group-id', 'group-'+parentId)
            .attr('id', 'group-'+parentId+'.'+i)
            .attr('group-id', 'group-'+parentId+'.'+i)
            .attr('nof-kids', 0)
            .attr('total-nof-kids', 0)
        var familyNew = familyGroupNew.use(familyDef).addClass('rule-family').move(
                leftStart,
                topStart
            )
            .attr('parent-group-id', 'group-'+parentId)
            .attr('parent-id', parentId)
            .attr('group-id', 'group-'+parentId+'.'+i)
            .attr('id', parentId+'.'+i)
        connectFamilies(familyGroupNew, family, familyNew)
        leftStart = leftStart + bbox.w + boxDiff;
        children.push(familyNew)
        i++;
    }
    incAttr(group, 'nof-kids', nof)
    updateParentKids(group, nof)
//    alert('done adding to '+group.attr('id'))
    return children;
}


function totalWidthOfChildren(group) {
    var totalWidth = 0
    forEachChildGroup(group, function(topFamily, childGroup) {
        var childWidth = groupWidthNoConnectors(childGroup)
        totalWidth = totalWidth + childWidth + boxDiff
    })
    totalWidth = totalWidth - boxDiff
    return totalWidth
}

function updateParentKids(group, nof) {
    incAttr(group, 'total-nof-kids', nof)
    var parentGroup = getParentGroup(group)
    if (parentGroup) {
        if (nof > 0) {
            var totalWidth = totalWidthOfChildren(parentGroup)        
            var parentFamily = parentGroup.first()
            
            //var fbox = parentGroup.rbox()
            var fbox = parentFamily.rbox()
            var leftStart = fbox.x + fbox.w/2 - totalWidth / 2
                console.log('left start = '+leftStart)
            forEachChildGroup(parentGroup, function(topFamily, childGroup) {
                var minMax = maxLeftRight(childGroup)
                var diff = leftStart-minMax[0]
                if (diff != 0) {
                    console.log('move '+childGroup.attr('id')+' to '+ leftStart)
                    childGroup.move(leftStart, 0)
                    connectFamilies(childGroup, parentFamily, childGroup.first())
                } else {
                    console.log('no move '+childGroup.attr('id'))
                }
                leftStart = leftStart + minMax[1]-minMax[0] + boxDiff
                console.log('left start = '+leftStart)
            })
        }
        updateParentKids(parentGroup, nof)
    }
}


/* helper funcions */


function forEachChildGroup(group, callback) {
    group.each(function(i) {
        if (this.hasClass('group-rule-family')) {
            callback(group.first(), this)
        }
    })
}

function getParentGroup(node) {
    if (node.attr('parent-group-id') != '') {
        return getGroupElemById(node.attr('parent-group-id'))
    } else {
        return null
    }
}
function getGroup(node) {
    return getGroupElemById(node.attr('group-id'))
}


function incAttr(node, attr, nof) {
    node.attr(attr, node.attr(attr) + nof)
//    console.log('update '+node.attr('id')+"."+attr+' = '+node.attr(attr))
}


function parentId(id) {
    var pos = id.lastIndexOf('.')
    if (pos < 0) {
        pos = id.lastIndexOf('-')
    }
    return id.substr(0, pos)
}
function previousId(id) {
    var pos = id.lastIndexOf('.');
    if (pos < 0) {
        pos = id.lastIndexOf('-');
    }
    var prefix = id.substr(0, pos+1)
    var idNo = id.substr(pos+1)    
    var no = parseInt(idNo, 10)
    if (no == 0) return null;
    no--
    return prefix+no;
}

function nextId(id) {
    var pos = id.lastIndexOf('.');
    if (pos < 0) {
        pos = id.lastIndexOf('-');
    }
    var prefix = id.substr(0, pos+1)
    var idNo = id.substr(pos+1)    
    var no = parseInt(idNo, 10)
    if (no == 0) return null;
    no++
    return prefix+no;
}

function getGroupElemById(id) {
    if (id) {
        if (!id.startsWith('group-')) {
            id = 'group-'+id
        }
        var idElem = document.getElementById(id)
        if (idElem) {
            return idElem.instance
        }
    }
    return null
}

function getConnectorById(id) {
    if (id) {
        if (!id.startsWith('rule-connector-')) {
            id = 'rule-connector-'+id
        }
        var idElem = document.getElementById(id)
        if (idElem) {
            return idElem.instance
        }
    }
    return null
}

function maxLeftRightInner(node, maxLeftRightArray) {
    node.each(function(i) {
        if (this.hasClass('rule-family')) {
            maxLeftRightArray[0] = Math.min(this.rbox().x, maxLeftRightArray[0])
            maxLeftRightArray[1] = Math.max(this.rbox().x2, maxLeftRightArray[1])
        } else if (this.hasClass('group-rule-family')) {
            maxLeftRightInner(this, maxLeftRightArray)
        }
    })
}

function maxLeftRight(group) {
    var minMax = [Number.MAX_SAFE_INTEGER,Number.MIN_SAFE_INTEGER]
    maxLeftRightInner(group, minMax)
    return minMax
}

function groupWidthNoConnectors(group) {
    var minMax = maxLeftRight(group)
    return minMax[1] - minMax[0]
}



}


drawRuleFamilyGraph()
