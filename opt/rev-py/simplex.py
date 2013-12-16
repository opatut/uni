#!/usr/bin/env python2
# coding=utf-8

import sys
from numpy import matrix, linalg, identity, array, copy, concatenate
from fractions import Fraction, Rational

def to_frac(v):
    v = Fraction(v)
    v = v.limit_denominator(1000)
    v = str(v)
    if "/" in v:
        v = v.split("/")
        v = "\\frac{%s}{%s}" % (v[0], v[1])
    return v


print '''
\\newcommand{\\authorinfo}{Paul Bienkowski, Nils Rokita, Arne Struck}
\\newcommand{\\titleinfo}{Optimierung Blatt 09 zum 16.12.2013}

% PREAMBLE ===============================================================

\\documentclass[a4paper,11pt]{article}
\\usepackage[german,ngerman]{babel}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage[top=1.3in, bottom=1in, left=1.0in, right=0.6in]{geometry}
\\usepackage{lmodern}
\\usepackage{amssymb}
\\usepackage{mathtools}
\\usepackage{amsmath}
\\usepackage{enumerate}
\\usepackage{pgfplots}
\\usepackage{breqn}
\\usepackage{tikz}
\\usepackage{fancyhdr}
\\usepackage{multicol}

\\usetikzlibrary{calc}
\\usetikzlibrary{patterns}

\\newcommand{\\bra}[1]{\\left(#1\\right)}

\\author{\\authorinfo}
\\title{\\titleinfo}
\\date{\\today}

\\pagestyle{fancy}
\\fancyhf{}
\\fancyhead[L]{\\authorinfo}
\\fancyhead[R]{\\titleinfo}
\\fancyfoot[C]{\\thepage}

\\renewcommand\\arraystretch{1.4}

\\begin{document}
\maketitle
'''

def print_matrix(m, name="", labels=None):
    if name:
        print name, ' = '
    print '\\bordermatrix{'
    if labels:
        print ' & ',
        print ' & '.join(labels),
    else:
        print ' & ' * (m.shape[1]), '~'
    print '\\cr'
    for i in range(m.shape[0]):
        print ' & ',
        for j in range(m.shape[1]):
            v = m.item(i, j)
            print to_frac(v),
            if j < m.shape[1] - 1:
                print " & ",
        print '\\cr'
    print '}'

class StepData(object):
    def __init__(self, An, Ab, cn, cb, b, x_B_=None):
        self.An = An
        self.Ab = Ab
        self.cn = cn
        self.cb = cb
        self.xn = ["x_%s"%(i+1) for i in range(An.shape[1])]
        self.xb = ["x_%s"%(i+1+An.shape[1]) for i in range(Ab.shape[1])]
        self.b = b
        self.x_B_ = x_B_ or b
        self.y = None
        self.i = 0

def merge(*args):
    return concatenate(args, axis=1)

def do_simplex(data):
    print '$$'
    print_matrix(merge(data.An, data.Ab), "A", data.xn + data.xb)
    print ', '
    print_matrix(data.b, "b")
    print '$$ $$'
    print_matrix(merge(data.cn.T, data.cb.T), "c^T")
    print '$$'

    while True:
        print '\\textbf{%s. Iteration}:\n\n' % (data.i+1)

        print '\\underline{1. Schritt}:\n\n'
        if step_1(data): break

        print 'Es gilt $c_B^T = '
        print_matrix(data.cb.T)
        print '$. Die Lösung des Gleichungssystems $y^T B = c_B^T$ lautet'
        print '$$ y^T = '
        print_matrix(data.y.T)
        print '$$\n\n'

        print '\\underline{2. Schritt}:\n\n'
        if step_2(data): break
        print 'Es gilt $A_N = '
        print_matrix(data.An, labels=data.xn)
        print '$, $y^TA_N = '
        print_matrix(data.yT_An.T)
        print '$. Wir wählen somit als Eingangsvariable $'
        print data.xn[data.in_column]
        print '$, mit $a = '
        print_matrix(data.a)
        print '$'

        print '\n\n'

        print '\\underline{3. Schritt}:\n\n'
        if step_3(data): break
        print 'Lösung des Gleichungssystems $Bd = a$ ergibt $$d = '
        print_matrix(data.d)
        print '$$'

        print '\n\n'

        print '\\underline{4. Schritt}:\n\n'
        if step_4(data): break
        print 'Die Ungleichung $x_B^* - td \\geq 0$ lautet $$'
        print_matrix(data.x_B_)
        print ' - t '
        print_matrix(data.d)
        print '\\geq 0$$'
        print 'Das größte $t$, das dieses erfüllt, ist $t = %s$.' % to_frac(float(data.t))
        print 'Dies wird bestimmt durch $%s$, welches die Ausgangsvariable wird.' % data.xb[data.out_column]

        print '\n\n'

        print '\\underline{5. Schritt}:\n\n'
        if step_5(data): break
        print 'Nach Vertauschen der entsprechenden Zeilen gelten folgende Werte: $$x_B^* = '
        print_matrix(data.x_B_)
        print ', B = '
        print_matrix(data.Ab, labels=data.xb)
        print ', A_N = '
        print_matrix(data.An, labels=data.xn)
        print '$$'

        print '\n\n'

        data.i += 1
        print ''
        if data.i > 20:
            print "max iterations, cancel"
            break

def step_1(data):
    data.y = linalg.solve(data.Ab.T, data.cb)

def step_2(data):
    data.yT_An = matrix([[ (data.y.T * col.T).item(0, 0) ] for col in data.An.T])
    vals = sorted([(data.cn[i] - data.y.T * col.T, i) for i, col in enumerate(data.An.T)], reverse=True)
    if vals[0][0] <= 0:
        print "Keiner der Werte aus $y^T A_N = "
        print_matrix(data.yT_An.T)
        print "$ ist kleiner als der korrespondierende Wert in $c_N^T = "
        print_matrix(data.cn.T)
        print "$, somit ist diese Lösung optimal:"

        for x in range(data.An.shape[0]):
            x_ = "x_%s"%(x+1)
            print "$" + x_ + ' = ',
            if x_ in data.xb:
                print to_frac(data.x_B_[data.xb.index(x_)].item(0, 0)),
            else:
                print "0",
            print "$",
            print "." if x == data.An.shape[0]-1 else ", "

        return True

    # Find input variable and column
    data.in_column = vals[0][1]
    data.a = data.An.T[data.in_column].T # get n-th column vector

    return False

def step_3(data):
    data.d = linalg.solve(data.Ab, data.a)

def step_4(data):
    mins = []
    for i, x in enumerate(data.x_B_):
        d = data.d[i]

        if d == 0:
            if x < 0:
                print "schon kacke"
                return True
        if (d <= 0) != (x <= 0):
            continue

        t = x / d
        mins.append((t, i))

    if not mins:
        print "unbeschraenkt"
        return True

    mins.sort(reverse=False)
    data.t = mins[0][0]
    data.out_column = mins[0][1]
    return False

def step_5(data):
    data.x_B_ = data.x_B_ - data.t.item(0, 0) * data.d
    data.x_B_[data.out_column] = data.t

    i = data.in_column
    o = data.out_column

    for x in range(len(data.Ab)):
        data.Ab[x, o], data.An[x, i] = data.An[x, i], data.Ab[x, o]

    tmp = copy(data.cb[o])
    data.cb[o] = data.cn[i]
    data.cn[i] = tmp

    tmp = data.xb[o]
    data.xb[o] = data.xn[i]
    data.xn[i] = tmp


data_a = StepData(
    matrix([[1, -4], [1, 0], [0, 1]]),
    identity(3),
    matrix([[2],[3]]),
    matrix([[0], [0], [0]]),
    matrix([[2], [5], [8]])
    )

data_b = StepData(
    matrix([[1, 0, 1], [1, 1, 0], [1, 2, 0]]),
    identity(3),
    matrix([[3],[2],[2]]),
    matrix([[0], [0], [0]]),
    matrix([[8], [7], [12]])
    )

data_2 = StepData(
    matrix([[1, 2, 3, 1], [1, 1, 2, 3]]),
    identity(2),
    matrix([[5],[6],[9],[8]]),
    matrix([[0], [0]]),
    matrix([[5], [3]])
    )

print '\\begin{enumerate}'
print '\\item[\\textbf{1.}]'
print '\\begin{enumerate}'
print '\\item[a)]'
do_simplex(data_a)
print '\\newpage'
print '\\item[b)]'
do_simplex(data_b)
print '\\end{enumerate}'
print '\\newpage'
print '\\item[\\textbf{2.}]'
do_simplex(data_2)
print '\\end{enumerate}'
print '\\end{document}'
