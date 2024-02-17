#import "@preview/physica:0.9.2": bra, ket, expval, braket, ketbra, vecrow, Tr, dmat, Order

#set par(leading: 0.55em, justify: true, linebreaks: "optimized")
#set text(font: "New Computer Modern", lang: "en")
#set heading(numbering: "1. ")
#show par: set block(spacing: 1em)
#show raw: set text(font: "Courier New", size: 11pt)
#show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt
)

#show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
}

#let ubs(x) = $upright(bold(sans(#x)))$

#outline(
    indent: auto
)

#pagebreak(weak: true)
= Qubits

A classical computer operates on strings of 0s and 1s. Each bit can be in one (and only one) of the two states.

The two single-qubit states can be represented using two *orthogonal#footnote[their dot product is 0, i.e. $sum_(i = 0)^(n) x_i y_i = 0$] unit#footnote[a vector with all compoents equal to 0 except one which is equal to 1] vectors* in a 2-dimentional vector space:
$ 
    ket(0) = vec(1, 0) quad ket(1) = vec(0, 1) 
$

Two-qubit states can be written as a *tensor product* of single-qubit states:
$ 
    ket(00) = ket(0) times.circle ket(0) = vec(1 dot vec(1, 0), 0 dot vec(1, 0)) = vec(1, 0, 0, 0) quad quad ket(01) = ket(0) times.circle ket(1) = vec(1 dot vec(0, 1), 0 dot vec(0, 1)) = vec(0, 1, 0, 0) \
    ket(10) = ket(1) times.circle ket(0) = vec(0 dot vec(1, 0), 1 dot vec(1, 0)) = vec(0, 0, 1, 0) quad quad ket(11) = ket(1) times.circle ket(1) = vec(0 dot vec(0, 1), 1 dot vec(0, 1)) = vec(0, 0, 0, 1)
$

In general, an $n$-qubit state can be represented by a unit $2^n$-component vector:
#figure(
    $
        ket(5)_3 = ket(101) = vec(0 dot vec(1 dot vec(0, 1), 0 dot vec(0, 1)), 1 dot vec(1 dot vec(0, 1), 0 dot vec(0, 1))) = vec(0 dot vec(0, 1, 0, 0), 1 dot vec(0, 1, 0, 0)) = vec(0, 0, 0, 0, 0, 1, 0, 0)
    $,
    kind: "equation",
    supplement: "Equation",
    caption: [Vector representation of $ket(5)_3$]
)

== Quantum gates and reversible operations

In classical computing, ${and, not}$ is a *universal set* of operators: any binary operation can be written as a combination of these two operators.

The $and$ operator is not *reversible* in the general case: if $a and b = 0$, the state of $a$ and $b$ cannot be determined by just looking at the result. \
The $not$ operator instead it's reversible. In particular, is its own inverse:
$
    not(not a) = a
$

#highlight(fill: yellow)[In quantum computing all gates are reversible], except for the special measurement gate.

All quantum gates can be represented by a *unitary* square matrix with complex coefficients.

In quantum physics, an *invertible* square matrix is said to be unitary if its inverse $U^(-1)$ is equal to its *Hermitian adjoint* $U^dagger$. $U^dagger$ is obtained from $U$ by first trasposing it and then applying the *complex conjugate*#footnote[for a complex number $a + i b$, its complex conjugate is $a - i b$] to each coefficient.

If $U$ is unitary, and therefore $U^(-1) = U^dagger$, it follows that $U U^dagger = U^dagger U = I$, where $I$ is the identity matrix.

=== Single-qubit gates

These gates acts on a *single* qubit at a time.

==== NOT gate

Flips the state of the qubit it acts on:
$
    ubs(X)ket(0) = ket(1) quad quad ubs(X)ket(1) = ket(0) quad quad ubs(X) = mat(0, 1; 1, 0)
$

==== Identity gate

It's the equivalent of the *identity matrix*:
$
    ubs(1)ket(0) = ket(0) quad quad ubs(1)ket(1) = ket(1) quad quad ubs(1) = mat(1, 0; 0, 1)
$

=== 2-qubit gates

These gates acts on 2 qubits at a time. The first is the *control* qubit, which determines what action occur on the second qubit (the *target* qubit).

==== SWAP gate

Swaps the control with the target qubit:
$
    ubs(S)_10 ket(x y) = ubs(S)_01 ket(x y) = ket(y x) quad quad ubs(S)_10 = ubs(S)_01 = mat(1, 0, 0, 0; 0, 0, 1, 0; 0, 1, 0, 0; 0, 0, 0, 1)
$

==== CNOT gate

Flips the state of the target qubit only if the control qubit is in state $ket(1)$:
$
    ubs(C)_10 ket(x y) = ket(x)ket(y plus.circle x) quad quad ubs(C)_01 ket(x y) = ket(x plus.circle y)ket(y) quad quad ubs(C)_10 = mat(1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 0, 1; 0, 0, 1, 0)
$

=== Number operator

This operator (which is not a gate) is the *projector operator* onto the state $ket(1)$#footnote[i.e. it counts the number of 1s in the quantum state]:
$
    ubs(n)ket(x) = x ket(x) quad quad x in {0, 1} quad quad ubs(n) = mat(0, 0; 0, 1)
$

The complementary operator $tilde(ubs(n))$ instead is the projector operator onto the state $ket(0)$#footnote[i.e. it counts the number of 0s in the quantum state]:
$
    tilde(ubs(n)) = ubs(1) - ubs(n) quad quad tilde(ubs(n)) = mat(1, 0; 0, 0)
$

=== $ubs(Z)$ operator

This operator has no counterpart in classical computation. It can be defined out of $ubs(n)$ and $tilde(ubs(n))$ operators:
$
    ubs(Z) = tilde(ubs(n)) - ubs(n) = mat(1, 0; 0, -1)
$

This operator adds a phase to the state $ket(1)$.

$ubs(Z)$ anticommutes with $ubs(X)$, i.e. $ubs(Z X) = -ubs(X Z)$.

=== Pauli gates

The set of operators ${ubs(X), ubs(Y), ubs(Z)}$ are called *Pauli gates*, with $ubs(Y)$ defined as
$
    ubs(Y) = mat(0, -i; i, 0)
$

When squared, all these operators are equal to the identity:
$
    ubs(X)^2 = ubs(Y)^2 = ubs(Z)^2 = ubs(1)
$

Also, they anticommute in pairs:
$
    ubs(X Y) = -ubs(Y X) = i ubs(Z) quad quad ubs(Y Z) = - ubs(Z Y) = i ubs(X) quad quad ubs(Z X) = -ubs(X Z) = i ubs(Y)
$

=== Hadamard gate

This is another quantum gate which does not have a counterpart in classical computation:
$
    ubs(H) = 1/sqrt(2)(ubs(X) + ubs(Z)) = 1/sqrt(2)mat(1, 1; 1, -1)
$

$ubs(H)$ is able to set the qubit in a *linear superposition* of $ket(0)$ and $ket(1)$:
$
    ubs(H)ket(0) = 1/sqrt(2)(ket(0) + ket(1)) = ket(+) quad quad ubs(H)ket(1) = 1/sqrt(2)(ket(0) - ket(1)) = ket(-)
$

$ubs(H)$ exibits some properties from its definition:
$
    ubs(H)^2 = 1 quad quad ubs(H X H)  = ubs(Z) quad quad ubs(H Z H) = ubs(X)
$

#highlight(fill: yellow)[These properties are used a lot when building quantum circuits].

$ubs(H)$ is also able to exchange the role of control and target qubit of a `CNOT` gate:
$
    ubs(C)_(j i) = (ubs(H)_i ubs(H)_j)ubs(C)_(i j)(ubs(H)_i ubs(H)_j)
$

== Qubits and their states

The state $ket(psi)$ associated with a qubit can be any unit vector in the 2-dimensional vector space spanned by $ket(0)$ and $ket(1)$ over the complex numbers.

The general form of a qubit is:
$
    ket(psi) = alpha_0 ket(0) + alpha_1 ket(1) = vec(alpha_0, alpha_1) quad quad alpha_0, alpha_1 in CC
$

Since $ket(psi)$ must be a *unit vector* in the complex vector space, coefficients $alpha_0$ and $alpha_1$ must satisfy the *normalization condition*:
$
    |alpha_0|^2 + |alpha_1|^2 = 1
$

If this is not true, the state $ket(psi)$ does not represent the state of a qubit.

#pagebreak(weak: true)
The normalization condition can also be expressed using the bra-ket notation:
$
    & braket(psi) = 1 \
    => & (alpha_0^*bra(0) + alpha_1^*bra(1))(alpha_0ket(0) + alpha_1ket(1)) = 1 \
    => & underbrace(alpha_0^*alpha_0, |alpha_0|^2)underbrace(braket(0), 1) + alpha_0^*alpha_1 underbrace(braket(0, 1), 0) + alpha_1^*alpha_0 underbrace(braket(1, 0), 0) + underbrace(alpha_1^*alpha_1, |alpha_1|^2)underbrace(braket(1), 1) = 1 \
    => & |alpha_0|^2 + |alpha_1|^2 = 1
$
where $alpha_i^*$ is the *complex conjugate* of $alpha_i$ and $braket(0, 1) = braket(1, 0) = 0$ because $ket(0)$ and $ket(1)$ are orthogonal.

Since $alpha_0, alpha_1 in bb(C)$, we can say that in a single qubit there are 4 _degrees of freedom_, one for each real number#footnote[for a complex number $z = a + i b$ there are 2 real numbers, $a$ and $b$]. This condition fixes one of them, so we are left with 3 degrees of freedom.

=== Normalization and phase of a complex number

The same complex number $z$ can be represented in two equivalent forms:
#figure(
    table(
        columns: (auto, auto, auto),
        align: (left + horizon, center + horizon, left + horizon),
        [*cartesian representation*], [$ z = a + i b $], [$a$ is the *real part* and $b$ is the *imaginary part*],
        [*polar representation*], [$ z = r e^(i phi) $], [$r$ is the *magnitue* and $phi$ is the *phase*]
    ),
    caption: [Cartesian and polar representation of a complex number $z$]
)

One can switch easily between these two representation thanks to the *Euler's formula*:
#figure(
    table(
        columns: (auto, auto),
        align: (center + horizon, center + horizon),
        [cartesian $-->$ polar], [polar $-->$ cartesian],
        [$ r = sqrt(a^2 + b^2) \ phi = arccos(a / r) = arcsin(b / r) $], [$ a = r cos phi \ b = r sin phi $] 
    ),
    caption: [Switch between complex number representations]
)

Therefore $ket(psi)$ can be written also using polar coordinates:
$
    alpha_0ket(0) + alpha_1ket(1) <=> r_0 e^(i phi_0)ket(0) + r_1 e^(i phi_1)ket(1)
$

When computing the modulus of a complex number the phase is irrelevant:
$
    |alpha|^2 = alpha^* alpha = r e^(-i phi)r e^(i phi) = r^2(cancel(e^(-i phi + i phi))) = r^2
$
so the normalization condition, expressed using polar coordinates, becomes:
$
    r_0^2 + r_1^2 = 1
$

This means that if two quantum states $ket(psi_1), ket(psi_2)$ differ only by their phase component then they are representing the *same qubit*. In other words, #highlight(fill: yellow)[the *global* phase of a quantum state is irrelevant] and can be collected:
$
    r_0 e^(i phi_0)ket(0) + r_1 e^(i phi_1)ket(1) = e^(i phi_1)(r_0 e^(i(phi_0 - phi_1))ket(0) + r_1 ket(1))
$

#highlight(fill: yellow)[However, the *local* phase of a quantum state (i.e. the phase of the *single* component) cannot be ignored].

#pagebreak(weak: true)
== Measurement and Born rule

A qubit can be in any linear superposition of $ket(0)$ and $ket(1)$, but when *measured* the outcome is either 0 or 1. There is no way to get the amplitudes $alpha_0, alpha_1$ from a measurement and therefore #highlight(fill: yellow)[there is no way to know the *state* of a qubit].

The string of 0s and 1s obtained by measurement is not determined by the quantum state $ket(psi)$. Instead, the state determines only the *probabilities* of the possible outcomes.

#table(
    columns: (1fr),
    [
        *Born rule*: for an $n$-qubit state $ket(Psi)_n = sum_(i <= n < 2^n)a_x ket(x)_n$, the *probability* that the outcome of a measurement is the binary expansion of $x$ is given by:
        $
            p(x) = |alpha_x|^2
        $
    ]
)

Example: for the single-qubit state $ket(psi) = alpha_0 ket(0) + alpha_1 ket(1)$, the probability of getting `1` from the measurement is $|alpha_1|^2$.

Born rule explains why the quantum state must be normalized in order to represent a qubit: the sum of the probabilities of all possible outcomes must be exactly 1.

Born rule has also another part: #highlight(fill: yellow)[measurement *changes* the state of the quantum system]. After the measurement, the only state that remains is the one obtained from the measurement. In order words, #highlight(fill: yellow)[the system *collapses* on the state obtained from the measurement].

#figure(
    image("assets/5b35c9f58eda95fc205928592948f6a2.png", width: 50%),
    caption: [After measurement, state $ket(psi)$ collapses to state $ket(x)$ with a probability of $|alpha_x|^2$]
)

However, if measurement of quantum state $ket(psi)$ returns $x$, it does not mean that the state of the quantum system was $ket(x)$. In general, #highlight(fill: yellow)[we can't say in which state the quantum system was before the measurement].

#highlight(fill: yellow)[The probabilistic nature of quantum physics comes from the *ignorance of the observer*], because we don't know the state of the system. However, #highlight(fill: yellow)[for the system itself its state is deterministic].

=== Measurement and relative phases

Relative phases are really relevant, but they cannot be inferred by a simple measurement, i.e. they are not *observable*.

These two states represent the *same qubit*:
$
    ket(psi_0) = ubs(H)ket(0) = 1/sqrt(2)(ket(0) + ket(1)) quad quad ket(psi_1) = ubs(H)ket(1) = 1/sqrt(2)(ket(0) - ket(1))
$

Indeed, the probability of getting 0 or 1 from a measurement is the same for both $ket(psi_0)$ and $ket(psi_1)$:
$
    p_0(0) = (1/sqrt(2))^2 = 1/2 quad quad p_0(1) = (1/sqrt(2))^2 = 1/2 \
    p_1(0) = (1/sqrt(2))^2 = 1/2 quad quad p_1(1) = (-1/sqrt(2))^2 = 1/2
$

However, even though $ket(psi_0)$ and $ket(psi_1)$ represent the same qubit, they are not equal to each other.

#pagebreak(weak: true)
== Quantum entanglement

#table(
    columns: (1fr),
    [
        *Quantum entanglement*: the quantum state $ket(psi_(A B))$ of two qubits $A$ and $B$ is *entangled* if $ket(psi_(A B))$ cannot be factorized in the product of two single-qubit states $ket(psi_A)$ and $ket(psi_B)$ such that $ket(psi_(A B)) = ket(psi_A) times.circle ket(psi_B)$.
    ]
)

#figure(
    table(
        columns: (auto, auto, auto),
        align: (center + horizon, center + horizon, center + horizon),
        [*state*], [*is entangled?*], [*factorization*],
        [$ ket(Psi_1) = frac(1, sqrt(2))(ket(00) + ket(01)) $], [no], [$ ket(Psi_1) = frac(1, sqrt(2))[ket(0) times.circle (ket(0) + ket(1))] $],
        [$ ket(Psi_2) = frac(1, sqrt(2))(ket(00) + ket(11)) $], [yes], [N/A]
    ),
    caption: [Examples of an entangled and non-entangled state]
)

Entanglement is a property of a quantum state, not of a quantum system.

Entanglement is fundamental for quantum information processing. 

In an entangled 2-qubit state, the state of one qubit depends on the state of the other.

Entanglement cannot be revealed by measurement.

=== Check if a 2-qubit state is entangled

We can check explicitly if a 2-qubit state is entangled by solving a system of equations.

Example:
$
    ket(Psi_1) = 1/sqrt(2)(ket(00) + ket(01)) quad quad ket(Psi_2) = 1/sqrt(2)(ket(00) + ket(11))
$

If these states are not entangled, a tuple of coefficients $vecrow(a_i, b_i, c_i, d_i)$ must exists so that $ket(Psi)_i$ can be rewritten as
$
    ket(Psi_i) = (a_i ket(0) + b_i ket(1))(c_i ket(0) + d_i ket(1))
$

For $ket(Psi_1)$ such tuple does exist, because this system has a solution:
$
    cases(
        a_1 c_1 = 1,
        a_1 d_1 = 1,
        b_1 c_1 = 0,
        b_1 d_1 = 0
    )
$
What is the solution of this system is not relevant. What is relevant is that a solution does exist, therefore $ket(Psi_1)$ is not entangled.

However, for $ket(Psi_2)$ the system does not have any solution:
$
    cases(
        a_2 c_2 = 1,
        a_2 d_2 = 0,
        b_2 c_2 = 0,
        b_2 d_2 = 1
    )
$
therefore $ket(Psi_2)$ is entangled.

Quantum entanglement is one of the most unintuitive concept of quantum physics. From a classical point of view, the state of a car for example can be represented by its position and its velocity. If this (classical) system is splitted in two parts, the state of each subsystem is very well defined. This is not true instead for a quantum system if it's entangled.

Entanglement is bidirectional: if system $A$ is entangled with system $B$, then $B$ is entangled with $A$ too.

=== Entanglement and generalized Born rule

The generalized Born rule says that for an $n$-qubit system, we get the *same result* if we either:
- measure *all* of the $n$-qubits of our state;
- measure *a subset* of the $n$-qubits of our state

#highlight(fill: yellow)[The order in which we perform our measurements does not change the result].

In the generalized version, instead of measuring the state as a whole we measure only a *subset* of the system.

A general state of $n$-qubit can be written as $ket(Psi)_n = sum_x c_x ket(x)_n$. An $n + m$-qubit state can be written in the same way:
$
    ket(Psi)_(m + n) = sum_(x, y)a_(x y)ket(x)_m ket(y)_n
$

If one measures only the $m$ qubits forming the $ket(x)_m$ part of the state, the result will be a specific $ket(overline(x))$ with a probability of:
$
    p(tilde(x)) = sum_y |a_(tilde(x) y)|^2
$
and the system will collapse in the state $ket(tilde(x))ket(Phi)_n$, with $ket(Phi)_n$ defined as
$
    ket(Phi)_n = frac(1, sqrt(p(x)))sum_y a_(tilde(x) y)ket(y)_n
$

= The general computational process

Let's suppose we have an arbitrary function $f$ which takes $n$-qubit in input and gives $m$-qubit as a result. This $f$ is arbitrary and it may not be reversible. How can we compute $f$ on an arbitrary quantum bit state?

Solution: we define a quantum gate $ubs(U)_f$:
$
    ubs(U)_f (ket(x)_n ket(y)_n) = ket(x)_n ket(y plus.circle f(x))_m
$

where $ket(x)$ is the *input register* and $ket(y)$ is the *output register*. The input register is not changed by $ubs(U)_f$.

#figure(
    image("assets/450d22040f112b614a3935447740493d.png", width: 30%),
    caption: [Logical representation of $ubs(U)_f$]
)

$ubs(U)_f$ is reversible, and in particular is its own inverse:

$
    ubs(U)_f ubs(U)_f (ket(x) ket(y)) = ubs(U)_f (ket(x) ket(y plus.circle f(x))) = ket(x) ket(y plus.circle f(x) plus.circle f(x)) = ket(x)ket(y)
$

== Quantum parallelism

If we have an $n$-qubit register and we apply an Hadamard gate on each of these qubits, what we obtain is an *equally weighted linear superposition* of all possible $n$-qubit states:
$
    ubs(H)^(times.circle n)ket(0)_n = 1/sqrt(2^n)sum_(0 <= x < 2^n)ket(x)_n
$

By linearity of quantum physics, if we then apply $ubs(U)_f$ to this superposition we get
$
    ubs(U)_f (ubs(H)^(times.circle n) times.circle ubs(1))(ket(0)_n ket(0)_m) = 1/sqrt(2^n)sum_(0 <= x < 2^n)ket(x)_n ket(f(x))_m
$

This final state contains the result of $2^n$ evaluations of $f$, by just a *single* execution of $ubs(U)_f$. This magic is called *quantum parallelism*.

However, we cannot exploit quantum parallelism in a trivial way, because when we measure the final state, even though it represents the result of all $2*n$ evaluations of $f$, we get a single (and random) result.

Not all algorithms benefits from quantum processing because of its *probabilistic nature*. If we are interested in *all* of $2^n$ outputs of $f(x)$, then we must use the classical approach (i.e. executing $f$ $2^n$ times). However, if we are interested in other aspects of the problem, quantum processing may provide an enourmus speedup compared to classical processing.

= No cloning theorem

#table(
    columns: (1fr),
    [
        *No cloning theorem*: there is no unitary transformation $ubs(U)_f$ that can take the state $ket(psi)_n ket(0)_n$ into the state $ket(psi)_n ket(psi)_n$ for an arbitrary $ket(psi)_n$.
    ]
)

In other words, this theorem says that we cannot *copy* the input register into the output register, i.e. *cloning* $ket(psi)_n$.

== Proof

Let's suppose by absurd that such $ubs(U)$ exists. Therefore for tho states $ket(psi), ket(phi.alt)$ we have:
$
    ubs(U)(ket(psi)ket(0)) = ket(psi)ket(psi) quad quad ubs(U)(ket(phi.alt)ket(0)) = ket(phi.alt)ket(phi.alt)
$

Since $ubs(U)$ can clone any input, it can also clone any linear superposition of $ket(psi)$ and $ket(phi.alt)$:
$
    ubs(U)[(a ket(psi) + b ket(phi.alt))ket(0)] & = (a ket(psi) + b ket(phi.alt))(a ket(psi) + b ket(phi.alt)) \
    & = a^2 ket(psi)ket(psi) + a b ket(psi)ket(phi.alt) + a b ket(phi.alt)ket(psi) + b^2 ket(phi.alt)ket(phi.alt)
$
but this result is in constract with the *linearity of quantum physics*:
$
    ubs(U)[(a ket(psi) + b ket(phi.alt))ket(0)] & = a ubs(U)ket(psi)ket(0) + b ubs(U)ket(phi.alt)ket(0) \
    & = a ket(psi)ket(psi) + b ket(phi.alt)ket(phi.alt)
$

This result is different from the one above unless either $a = 1$ and $b = 0$ or viceversa, therefore such $ubs(U)$ cannot exist.

== No cloning theorem for approximations

#table(
    columns: (1fr),
    [
        *No cloning theorem* (for approximation): there is no unitary transformation $ubs(U)$ that can take the state $ket(psi)_n ket(0)_n$ into a state $ket(psi)_n ket(psi)_n$ such that $ubs(U)(ket(psi)_n ket(0)_n) approx ket(psi)_n ket(psi)_n$.
    ]
)

=== Proof

Let's suppose by absurd that such $ubs(U)$ exists, so:
$
    ubs(U)(ket(psi)ket(0)) approx ket(psi)ket(psi) quad quad ubs(U)(ket(phi.alt)ket(0)) approx ket(phi.alt)ket(phi.alt)
$

$ubs(U)$ is *unitary* by hypothesis, so it preserves the *scalar product* $braket(phi.alt, psi)$. In other words, this condition must be verified for $ubs(U)$ to exist:
$
    & braket(phi.alt, braket(0, psi), 0) approx braket(phi.alt, braket(phi.alt, psi), psi) \
    => & braket(phi.alt, psi)braket(0) approx braket(phi.alt, psi)braket(phi.alt, psi)
$

The state must be normalized, so $braket(0) = 1$, which laves:
$
    braket(phi.alt, psi) = (braket(phi.alt, psi))^2
$
which is not true in the general case, but only in two cases:
+ $braket(phi.alt, psi) = 0$, which means that $ket(psi)$ and $ket(phi.alt)$ are nearly *orthogonal* (which is true only for $ket(0)$ and $ket(1)$);
+ $braket(phi.alt, psi) = 1$, which means that $phi.alt = psi$, i.e. that we had to have 2 states which were already the same *before* cloning them

Therefore, since a *general* state $ket(psi)$ cannot be cloned even with an approximation error, such $ubs(U)$ does not exist.

= Spooky action at a distance

Let's consider the *Hardy state*:
$
    ket(Phi) & = frac(1, sqrt(12))(3ket(00) + ket(01) + ket(10) - ket(11)) \
    & = 1/sqrt(3)(2ket(00) - ubs(H)_a ubs(H)_b ket(11))
$

If Alice and Bob measure their qubit now, the probability of both getting a `1` is $(-1/sqrt(12))^2$. In particular, this probability is $!= 0$.

But if both Alice and Bob apply an Hadamard *before* measuring their qubit, the probability of both getting `1` is $= 0$:
$
    ubs(H)_a ubs(H)_b ket(Phi) & = 1/sqrt(3)(2ubs(H)_a ubs(H)_b ket(00) + cancel(ubs(H)_a^2)cancel(ubs(H)_b^2)ket(11)) \
    & = frac(1, sqrt(3))(ket(00) + ket(01) + ket(10) + cancel(ket(11)) - cancel(ket(11)))
$

This can be easily spotted from the expression above: the state $ket(11)$ does not exist anymore.

If only Alice applies an Hadamard before the measurement, this will remove the outcome `01` from the possible results:
$
    ubs(H)_a ket(Phi) = 1/sqrt(3)(2ubs(H)_a ket(00) - ubs(H)_b ket(11))
$

Since $ubs(H)_a ket(00)$ is a linear combination of $ket(00)$ and $ket(11)$ and $ubs(H)_b ket(11)$ is a linear combination of $ket(10)$ and $ket(11)$, the state $ket(01)$ does not appear in the expansion of $ubs(H)_a ket(Phi)$.

#highlight(fill: yellow)[The spooky part about this is that by applying an Hadamard on her qubit, Alice has also affected the possible outcomes for Bob], even though she hasn't touched its qubit. This is because of Alice and Bob qubits are entangled.

The same spooky action happens if only Bob applies an Hadamard to his qubit. This will remove the outcome `10`:
$
    ubs(H)_b ket(Phi) = 1/sqrt(3)(2ubs(H)_b ket(00) - ubs(H)_a ket(11))
$

#figure(
    image("assets/c46bef02628528cb1d56757307d19584.png", height: 15%),
    caption: [Summary of possible outcomes]
)

This set of possible outcomes is inconsistent with classical physics. It's only valid for quantum physics.

#highlight(fill: yellow)[This is also an alternative experiment that evaluates the truth of *Bell's inequality*].

= Deutsch's problem

Let's consider a function $f : {0, 1} |-> {0, 1}$. There can be only 4 of these functions:
#figure(
    table(
        columns: (auto, auto, auto),
        [], [$ x = 0 $], [$ x = 1 $],
        [$ f_0 $], [$ f(x) = 0 $], [$ f(x) = 0 $],
        [$ f_1 $], [$ f(x) = 0 $], [$ f(x) = 1 $],
        [$ f_2 $], [$ f(x) = 1 $], [$ f(x) = 0 $],
        [$ f_3 $], [$ f(x) = 1 $], [$ f(x) = 1 $]
    ),
    caption: [All possible $f_i$]
)

We can represent the quantum transformation that applies $f$ in the usual way:
$
    ubs(U)_f (ket(x)ket(y)) = ket(x)ket(y plus.circle f(x))
$

Assuming that the input register is initialized to $ket(0)$, there are 4 distinct $ubs(U)_f_i$ (one for each $f_i$):
+ $ubs(U)_f_1 = ubs(1)$ because the output register is left to $ket(0)$ for both inputs $ket(0)$ and $ket(1)$;
+ $ubs(U)_f_1 = ubs(C)_(10)$ because it changes the output register to $ket(1)$ only if the input register (used as the control qubit) is $ket(1)$;
+ $ubs(U)_f_2 = ubs(C)_(10)ubs(X)_0$ because it's simply the previous case with a NOT gate applied;
+ $ubs(U)_f_3 = ubs(X)_1$ because the output register is set to $ket(1)$ regardless of the input register

We assume that we have a *black box* that implements one of those $f_i$, but we don't know which one of them. Our goal is to determine if the $f_i$ inside the black box is *constant* or not.

With a classical approach we would need 2 evaluations of $f$ to determine this. Instead, with a quantum approach we can determine this with just a *single* evaluation of $f$.

However, it must be said that with a classical approach we would also know exactly *which* of those 4 $f$ is inside the black box. The quantum approach cannot tell us this, but it can tell us if the function is one of ${f_0, f_3}$ (constant) or of ${f_1, f_2}$ (not constant).

== Proof

Let's start with the state $(ubs(X) times.circle ubs(X))(ket(0)ket(0)) = ket(1)ket(1)$. We then apply an Hadamard gate on each qubit:
$
    (ubs(H) times.circle ubs(H))(ket(1)ket(1)) & = 1/2(ket(0) - ket(1))(ket(0) - ket(1)) \
    & = 1/2(ket(00) - ket(01) - ket(10) + ket(11))
$

This state is *not entangled*. This fact can be spotted by two things:
+ the state is clearly separable (look at the first expression);
+ we started from a non-entangled state and we have used only single-qubit gates. There was no interaction between the two qubits, therefore there cannot be any entanglement

If now we apply $ubs(U)_f$ to this state, by *linearity* we get:
$
    1/2[ubs(U)_f (ket(0)ket(0)) - ubs(U)_f (ket(0)ket(1)) - ubs(U)_f (ket(1)ket(0)) + ubs(U)_f (ket(1)ket(1))]
$

Now we apply $ubs(U)_f$ and rewrite the expression explicitly:
$
    1/2(ket(0)ket(0 plus.circle f(0)) - ket(0)ket(1 plus.circle f(0)) - ket(1)ket(0 plus.circle f(1)) + ket(1)ket(1 plus.circle f(1)))
$
and then we rename $tilde(f)(x) = ket(1 plus.circle f(x))$:
$
    1/2(ket(0)ket(f(0)) - ket(0)ket(tilde(f)(0)) - ket(1)ket(f(1)) + ket(1)ket(tilde(f)(1)))
$

Now, if $f$ is constant, then $f(0) = f(1)$, so we can collect either $f(0)$ or $f(1)$:
$
    1/2(ket(0) - ket(1))(ket(f(0)) - ket(tilde(f)(0))) quad quad f(0) = f(1) <=> tilde(f)(0) = tilde(f)(1)
$

If instead $f$ is not constant and then $f(0) != f(1)$, we can still collect something because in this case $f(0) = tilde(f)(1)$:
$
    1/2(ket(0) + ket(1))(ket(f(0)) - ket(tilde(f)(0))) quad quad f(0) != f(1) <=> f(0) = tilde(f)(1)
$

These two states are very similar. Indeed, the only difference is the sign. This difference however cannot be detected by a measurement, so we apply again an Hadamard on the input register in order to make these states clearly different:
$
    frac(1, 2)[ubs(H)(ket(0) - ket(1))](ket(f(0)) - ket(tilde(f)(0))) --> ket(1)frac(1, sqrt(2))(ket(f(0)) - ket(tilde(f)(0))) quad quad f(0) = f(1) \
    frac(1, 2)[ubs(H)(ket(0) + ket(1))](ket(f(0)) - ket(tilde(f)(0))) --> ket(0)frac(1, sqrt(2))(ket(f(0)) - ket(tilde(f)(0))) quad quad f(0) = tilde(f)(1)
$

If we now measure the *input* register and we get a $ket(0)$, then $f(0) = tilde(f)(1)$ (i.e. $f$ is not constant), instead if we get $ket(1)$ then $f(0) = f(1)$ (i.e. $f$ is constant).

Note that $ubs(U)_f$ has created entanglement. This is why we can get either $ket(0)$ or $ket(1)$ from the measurement even though we started from a non-entangled state $ket(1)$ on the input register.

To sumarize, this is the full chain of operations we have performed, starting from state $ket(0)ket(0)$:
$
    (ubs(H) times.circle ubs(1))ubs(U)_f (ubs(H) times.circle ubs(H))(ubs(X) times.circle ubs(X))(ket(0)ket(0)) = cases(
        ket(1)frac(1, sqrt(2))(ket(f(0)) - ket(tilde(f)(0))) "if" f(0) = f(1),
        ket(0)frac(1, sqrt(2))(ket(f(0)) - ket(tilde(f)(0))) "if" f(0) = tilde(f)(1)
    )
$

== Circuit representation

#figure(
    image("assets/c91fa2e59aad4b1f670c837d0fa36f2f.png", height: 22%),
    caption: [Circuit for the 4 $ubs(U)_f_i$]
)

#pagebreak(weak: true)
To solve the Deutch's problem we simply need to add a pair of Hadamard both before and after the processing:
#figure(
    image("assets/4ab06afeae03bea562a90e98d315f955.png", height: 22%),
    caption: [Circuit which solves the Deutsch's problem]
)

We have used these identities:
#figure(
    image("assets/2a74dbe72a1dd0099fe9ac54e03333c1.png", width: 50%),
    caption: [Identities used to build the circuit which solves the Deutsch's problem. The circuit on the left is *equivalent* to the circuit on the right.]
)

#pagebreak(weak: true)
= How to build the Hardy state

$
    ket(Phi) = frac(1, sqrt(12))(3ket(00) + ket(01) + ket(10) - ket(11)) = frac(1, sqrt(12))[ket(0)(3ket(0) + ket(1)) + ket(1)(ket(0) - ket(1))]
$

We want to build this state starting from $ket(00)$.

We will start with qubit 1 (i.e. the left-most qubit), which have this probability distribution:
$
    p_1(0) = frac(|3|^2 + |1|^2, 12) = 10/12 quad quad p_1(1) = frac(|1|^2 + |-1|^2, 12) = 2/12
$

To get these probabilities from $ket(0)$ we need a unitary transformation $ubs(U)$ such that
$
    ubs(U)ket(0) = frac(1, sqrt(12))(sqrt(10)ket(0) + sqrt(2)ket(1))
$

To find this $ubs(U)$, we first consider its general form:
$
    ubs(U)(theta, phi.alt, lambda) = mat(
        cos(frac(theta, 2)), -e^(i lambda)sin(frac(theta, 2));
        e^(i phi.alt)sin(frac(theta, 2)), e^(i(phi.alt + 1))cos(frac(theta, 2))
    )
$

We can find our $ubs(U)$ by finding the values of $theta, phi.alt$ and $lambda$.

Since our target state $ubs(U)ket(0)$ does not have any phase (all coefficients are real), we can put $phi.alt = lambda = 0$ and focus only on $theta$. We need to solve this equation in order to find its value:
$
    mat(cos(frac(theta, 2)), -sin(frac(theta, 2)); sin(frac(theta, 2)), cos(frac(theta, 2)))vec(1, 0) = frac(1, sqrt(12))(sqrt(10)vec(1, 0) + sqrt(2)vec(0, 1))
$

This equation is solved for $theta = 0.8410$, so the $ubs(U)$ we want is:
$
    ubs(U)(0.8410, 0, 0) = mat(cos(0.8410 / 2), -sin(0.8410 / 2); sin(0.8410 / 2), cos(0.8410 / 2)) = frac(1, sqrt(12)) mat(sqrt(10), -sqrt(2); sqrt(2), sqrt(10))
$

This $ubs(U)$ is the quantum gate we want for our *first* qubit. But we also need to handle the *second* qubit (the Hardy state is a 2-qubit state), so we need to find another unitary transformation $ubs(V)$.

Steps here are more complex, since the two qubits are *entangled*. The quantum gate we want should produce this result when applied to the first qubit:
$
    ubs(V)ket(0) = frac(1, sqrt(10))(3ket(0) + ket(1))
$

We can use the same procedure as before, i.e. we need to find for which $theta$ this equation is verified:
$
    ubs(V)(theta, 0, 0)vec(1, 0) = sqrt(10)(3vec(1, 0) + vec(0, 1))
$

We set $phi.alt = lambda = 0$ also in this case because also in this case our target state $ubs(V)ket(0)$ does not have any phase.

This equation is solved for $theta = 0.6435$, which gives this matrix:
$
    ubs(V)(0.6435, 0, 0) = frac(1, sqrt(10))mat(3, -1; 1, 3)
$

Now we combine $ubs(U)$ and $ubs(V)$ and see what these gates do on $ket(00)$:
$
    ubs(U)_1 ubs(V)_0 ket(00) = frac(1, sqrt(12))[ket(0)(3 ket(0) + ket(1)) + ket(1)(3 ket(0) + ket(1))]
$
but we notice that this is not the Hardy state.

So wee need a third quantum gate $ubs(K)$ that should be a *controlled* gate, because it should act on qubit 0 only if qubit 1 is $ket(1)$.

The procedure is still the same. Our goal for the second qubit is the linear superposition $ket(0) - ket(1)$ (as is in the Hardy state), so we need to find the value of $theta$ that verifies this equation:
$
    ubs(K)(theta, 0, 0)frac(1, sqrt(10))vec(3, 1) = frac(1, sqrt(2))vec(1, -1)
$
which is $theta = -2.2142$.

So we put all these gates together:
$
    ubs(K)_10 ubs(U)_1 ubs(V)_0 ket(00) = frac(1, sqrt(12))[ket(0)(3ket(0) + ket(1)) + ket(1)(ket(0) - ket(1))]
$
and we get the Hardy state.

#pagebreak(weak: true)
= Bernstein-Vazirani problem

Let $a$ be a non negative $n$-bit number, which is our _secret key_. We also have a function $f : {0, 1}^n |-> {0, 1}$ that computes the *scalar product modulo 2* between $a$ and the input $x$:
$
    f(x) = a dot x = a_0 x_0 plus.circle a_1 x_1 plus.circle ... plus.circle a_n x_n
$

Our goal is to find $a$, i.e. all the $n$ bits of which it is composed.

On a classical computer, we would need $n$ evaluations of $f$, one for each bit. For example, if $n = 3$:
$
    f_a (001) = a_0 quad quad f_a (010) = a_1 quad quad f_a (100) = a_3 quad quad ==> a = (a_2, a_1, a_0)
$

With a quantum approach, we need just a *single* evaluation of $f$ to find $a$, regardless of how big $n$ is, so we switch from a computational cost linear to $n$ (classic approach) to a constant computational cost (quantum approach).

We prepare the output register in state $ubs(H)ket(1) = ubs(H)ubs(X)ket(0) = frac(1, sqrt(2))(ket(0) - ket(1))$.

Since $ubs(H)ket(0) = frac(1, sqrt(2))(ket(0) + ket(1))$ and $ubs(H)ket(1) = frac(1, sqrt(2))(ket(0) - ket(1))$, we can write the general single-qubit state obtained by applying an Hadamard in this way:
$
    ubs(H)ket(x)_1 = frac(1, sqrt(2))(ket(0) + (-1)^x ket(1)) = frac(1, sqrt(2))sum_(y = 0)^(1)(-1)^(x y) ket(y)_1
$

Therefore the generalization of $ubs(H)$ for $n$-qubits can be written as
$
    ubs(H)^(times.circle n)ket(x)_n = frac(1, sqrt(2^n))sum_(y = 0)^(2^n - 1)(-1)^(x y)ket(y)_n
$

Now, since $ubs(U)_f ket(x)ket(y) = ket(x)ket(y plus.circle x)$, i.e. $ubs(U)_f$ flips the output register only if the input register has value 1, we have:
$
    ubs(U)_f ubs(H)_0 ubs(X)_0 ket(x)_n ket(0) = (-1)^(f(x))ket(x)_n frac(1, sqrt(2))(ket(0) - ket(1))
$

Now we apply again an Hadamard on each qubit of the input resiger:
$
    (ubs(H)^(times.circle n) times.circle ubs(1))ubs(U)_f (ubs(H)^(times.circle n) times.circle ubs(H))ket(0)_n ket(1)_1 & = (ubs(H)^(times.circle n) times.circle ubs(1))ubs(U)_f (frac(1, sqrt(2^n)) sum_(x = 0)^(2^n - 1)ket(x))frac(1, sqrt(2))(ket(0) - ket(1)) \
    & = frac(1, sqrt(2^n))(ubs(H)^(times.circle n)sum_(x = 0)^(2^n - 1)(-1)^(f(x))ket(x))frac(1, sqrt(2))(ket(0) - ket(1)) \
    & = frac(1, 2^n)sum_(x = 0)^(2^n - 1)sum_(y = 0)^(2^n - 1)(-1)^(f(x) + x dot y)ket(y)frac(1, sqrt(2))(ket(0) - ket(1))
$

Now we use an identity to rewrite the sum over $x$:
$
    sum_(x = 0)^(2^n - 1)(-1)^(a dot x)(-1)^(y dot x) = product_(j = 1)^(n)sum_(x_j = 0)^(1)(-1)^((a_j + y_j)x_j)
$
and then we notice that at least one term of the product vanishes unless each bit $y_j$ of $y$ is equal to each bit $a_j$ of $a$, i.e. unless $y = a$.

We can now get the value of $a$ by measuring the input register.

== Circuit representation

The Bernstein-Vazirani problem can be demonstrated also by using a circuit diagram.

#figure(
    image("assets/24328cbc2160363c10e5a3ad9e77579c.png", width: 50%),
    caption: [Circuit that implements $ubs(U)_f$ for $f(x) = a dot x$]
)

Each of the cNOT gates adds $1 mod 2$ to the output register if and only if $a_j x_j = 1$, therefore there are as many cNOT gates as bits equal to 1 in $a$.

We now add the Hadamards:
#figure(
    image("assets/dbca55a67890d4be6e966b933d652e46.png", width: 50%),
    caption: [Circuit for the Bernstein-Vazirani problem]
)

We can simplify this circuit by considering a property of the Hadamard gate that, when applied to both the control and the target qubit, it flips the role of control and target qubit of a CNOT:
$
    (ubs(H)_i ubs(H)_j)ubs(C)_(i j)(ubs(H)_i ubs(H)_j) = ubs(C)_(j i)
$

#figure(
    image("assets/e4551e8f2d35757089c5c3205e436796.png", width: 60%),
    caption: [Circuit for the Bernstein-Vazirani problem (simplified)]
)

#pagebreak(weak: true)
= Building multi-qubit gates from 1- and 2-qubit gates: the Toffoli gate

The CNOT gate and a generica single-qubit gate form a *universal set* of quantum gates. Any quantum algorithm can be built entirely out of these gates.

Realizing hardware for quantum computers is really challenge. Currently, we are able to build single- and 2-qubit gates, but building 3- (or more) qubit gates is practically impossible.

The *Toffoli gate* is one example on how to build a 3-qubit gate out of 1- and 2-qubit gates:
$
    ubs(T)ket(x)ket(y)ket(z) = ket(x)ket(y)ket(z plus.circle x y)
$

$ubs(T)$ is its own inverse, therefore it's a unitary quantum gate.

If $z = 0$, the Toffoli gate can be used to compute the logical AND of two qubits. Since AND and NOT gates are a universal set of classical gates, #highlight(fill: yellow)[the Toffoli gate represents a universal set of quantum gates].

We need 3 things to build the Toffoli gate out of 1- and 2-qubit gates:
+ a *controlled* $ubs(U)$ gate;
+ a 3-qubit doubly-controlled $ubs(U)^2$ gate;
+ the *square root of NOT gate*, $sqrt(ubs(X))$

We can build a controlled $ubs(U)$ from 2 arbitrary single-qubit gates $ubs(V), ubs(W)$ and the CNOT:
#figure(
    image("assets/648202a1d5286108d053e141ef43dcf8.png", height: 8%),
    caption: [Building of a controlled $ubs(U)$ from 2 single-qubit arbitrary gates $ubs(V), ubs(W)$. The last $ubs(E)$ gate is a *phase shift* gate.]
)

From this controlled $ubs(U)$ gate, a doubly-controlled $ubs(U)^2$ gate can be constructed by putting together:
- two controlled $ubs(U)$ gates;
- one controlled $ubs(U)^dagger$ gate;
- two CNOT gates

#figure(
    image("assets/71c94f0b94048e48d6903856c751f389.png", height: 8%),
    caption: [Doubly-controlled $ubs(U)^2$ gate]
)

If we now consider the $ubs(U)$ to be the square root of not $sqrt(ubs(X))$ gate, we obtain the Toffoli gate:
#figure(
    image("assets/95a9e7a40a84c9dd917571bae5a1e243.png", height: 13%),
    caption: [The Toffoli gate]
)
which actually is a controlled-controlled-NOT gate.

The $ubs(T)$ gate in the circuit above is a single-qubit gate that *rotates* the state by a factor $pi/4$.

The last circuit comes from the fact that $sqrt(ubs(X)) = ubs(H)sqrt(ubs(Z))ubs(H)$, because $ubs(X) = ubs(H Z H)$ and $ubs(H)^2 = ubs(1)$.

== Examples of multi-qubit gates

#figure(
    image("assets/ed36f42cf0113b7faefe8213afdccec1.png", height: 13%),
    caption: [A quantum half adder using 4 qubits]
)

#figure(
    image("assets/8f6eaab83e4098c8c64d3d71946c27c0.png", height: 13%),
    caption: [A quantum full adder using 5 qubits]
)

We can build a quantum full adder also with only 4 qubits, but we lose the difference between the input and the output register:
#figure(
    image("assets/421dfc36bae98601c1eed7ee99f6a94c.png", height: 13%),
    caption: [Quantum full adder using 4 qubits]
)
but the circuit is still reversible, so it is a quantum circuit.

#pagebreak(weak: true)
= Von Neumann entanglement entropy

#highlight(fill: yellow)[The state of a classical system is always defined]. The observer may not be aware of it, but still it's defined.

A classical system can be described using a single variable and an *array* of states. #highlight(fill: yellow)[A quantum system instead must be represented by a 1D array (not a single variable) and a *matrix* with the *probability distribution* of the states].

A quantum system is in a *pure* state if its state is represented by a well-defined state vector $ket(psi)$. In a classical system made of two subsystems, each subsystem is always in a specific state. For quantum systems, this holds only if the state is *separable* in two subsystems, i.e. if the quantum state is *not entangled*.

#table(
    columns: (1fr),
    [*Density matrix*: the density matrix $rho$ of a system in a pure state is defined as $rho = ket(psi)bra(psi)$.]
)

#figure(
    table(
        columns: (auto, auto),
        align: (center + horizon, center + horizon),
        [*state* $ket(psi)$], [*density matrix* $rho$],
        [$ ket(psi_1) = ket(01) $], [$ rho = ket(01)bra(01) = vec(0, 1, 0, 0)mat(0, 1, 0, 0) = mat(0, 0, 0, 0; 0, 1, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0) $],
        [$ ket(psi_2) = frac(1, sqrt(2))(ket(00) + ket(11)) $], [$ rho = frac(1, 2)(ket(00) + ket(11))(bra(00) + bra(11)) = frac(1, 2)vec(1, 0, 0, 1)mat(1, 0, 0, 1) = frac(1, 2)mat(1, 0, 0, 1; 0, 0, 0, 0; 0, 0, 0, 0; 1, 0, 0, 1) $]
    ),
    caption: [Examples of density matrices. $ket(psi_2)$ is entangled.]
)

#highlight(fill: yellow)[The *reduced* density matrix of a quantum system is the density matrix of only a part of the system]. For example, the reduced density matrix on subsystem $B$ is the $2 times 2$ matrix obtained from $rho$ by *tracing out* the degrees of freedom of subsystem $B$. This is done by applying a *partial trace operation* on the density matrix $rho$.

For a $4 times 4$ matrix, the partial trace operation is defined as:
$
    Tr mat(
        #text(fill: red)[a], b, #text(fill: blue)[c], d; 
        e, #text(fill: red)[f], g, #text(fill: blue)[h] ; 
        #text(fill: green)[i], j, #text(fill: purple)[k], l; 
        m, #text(fill: green)[n], o, #text(fill: purple)[p]
    ) = mat(
        #text(fill: red)[a + f], #text(fill: blue)[c + h] ; 
        #text(fill: green)[i + n], #text(fill: purple)[k + p]
    )
$

The *Von Neumann entropy* $S(gamma)$ of a density matrix $gamma$ is defined as:
$
    S(gamma) = -Tr(gamma ln gamma)
$

This formula contains the *logarithm of a matrix*. In our case, since we deal only with *diagonal* matrices, the logarithm of a matrix is the same matrix with a logarithm applied to each of its coefficients:
$
    ln dmat(a, b) = dmat(ln a, ln b)
$

The *degree of entanglement* $Epsilon_(A, B)(rho)$ between qubit $A$ and qubit $B$ can be computed as the Von Neumann entropy of the reduced density matrix:
$
    Epsilon_(A, B)(rho) = S(rho_A) = -Tr(rho_A log_2 rho_A)
$

The basis of the $log$ is just a matter of normalization. In our case it's convenient to pick the basis 2 because in this way #highlight(fill: yellow)[the result can either be 0 (no entanglement at all), 1 (maximum entanglement possible) or something in between].\
In our case is also convenient to consider $log_2 0 = -infinity = 0$.

#highlight(fill: yellow)[The amount of entanglement is the amount of information one can get from a subsystem by measuring the other subsystem].

The amount of entanglement depends on the definition of the two subsystems. If the system is composed only of 2 qubits, there is a single way to split it in two subsystems (each subsystem is composed of just 1 qubit). If instead the system is composed of $>= 3$ qubits, there are $>= 2$ ways to split the system in two subsystems. #highlight(fill: yellow)[The amount of entanglement will likely be different for each different subdivision].

Example: let's reconsider state $ket(psi_2) = frac(1, sqrt(2))(ket(00) + ket(11))$:
#figure(
    table(
        columns: (auto, auto),
        align: (center + horizon, center + horizon),
        [*density matrix*], [*reduced density matrix*],
        [$ rho = frac(1, 2)mat(1, 0, 0, 1; 0, 0, 0, 0; 0, 0, 0, 0; 1, 0, 0, 1) $], [$ rho_A & = frac(1, 2)mat(1 + 0, 0 + 0; 0 + 0, 0 + 1) = 1/2 mat(1, 0; 0, 1) $]
    ),
    caption: [Density matrix and reduced density matrix for subsystem $A$ of state $ket(psi_2)$]
)

The Von Neumann entropy of $rho_A$ is:
$
    Epsilon_(A, B)(rho) & = -Tr[1/2 mat(1, 0; 0, 1) log_2 frac(1, 2)mat(1, 0; 0, 1)] \
    & = -Tr[mat(1/2, 0; 0, 1/2)mat(-1, 0; 0, -1)] = 1
$

So subsystems $A$ and $B$ have the maximum entanglement possible.

Let's now consider another entangled state $ket(psi_3) = frac(1, sqrt(5))(ket(00) + 2ket(11))$:
#figure(
    table(
        columns: (auto, auto),
        align: (center + horizon, center + horizon),
        [*density matrix*], [*reduced density matrix*],
        [$ rho = frac(1, 5)mat(1, 0, 0, 2; 0, 0, 0, 0; 0, 0, 0, 0; 2, 0, 0, 4) $],
        [$ rho_A = frac(1, 5)mat(1 + 0, 0 + 0; 0 + 0, 0 + 4) = 1/5 mat(1, 0; 0, 4) $]
    ),
    caption: [Density matrix and reduced density matrix of $ket(psi_3)$]
)

The Von Neumann entropy of $rho_A$ is:
$
    Epsilon_(A, B)(rho_A) & = -Tr[1/5 mat(1, 0; 0, 4)log_2 1/5 mat(1, 0; 0, 4)] = 0.722
$
therefore $A$ and $B$ are not partially entangled.

#pagebreak(weak: true)
= Simon's problem

Let's consider a function $f : {0, 1}^n |-> {0, 1}^n$ with an unknown *periodicity* $a$:
$
    f(x) = f(y) <=> y = x plus.circle a
$

Our goal is to discover the period $a$.

== Classical approach

A classical approach requires multiple evaluations of $f$, each with a different input $x_i$ and storing each output $f(x_i)$. When one finds an input $x_j$ for which $f(x_j)$ has already been seen for some input $x_i$, then $a = x_i plus.circle x_j$.

The number of times $f$ needs to be evaluated grows *exponentially* with $n$, i.e. the computational cost is $Order(sqrt(2^n))$.

The cost of this algorithm is so high because after $m$ evaluations of $f$, if $a$ has not been found yet, we have ruled out only $1/2 m(m - 1)$ possibilites for $a$, which is a very small number if compared to the total number of possibilites for $a$ (which is $2^n - 1$).

== Quantum approach

A quantum computer can determine $a$ by running $f$ only about $n$ times (actually a little more, but still the cost is *linear*).

However, the algorithm changes its nature because it becomes a *probabilistic algorithm*: $a$ may not be found with a probability of 100%, but the chance of failing for this algorithm is $< 10^(-6)$.

As usual, the input register is prepared in a uniformly weighted superposition and the output register in the state $ket(0)$:
$
    (ubs(H)^(times.circle n) times.circle ubs(1))ket(0)_n ket(0)_n = frac(1, sqrt(2^n))sum_(x = 0)^(2^n - 1)ket(x)ket(0)_n
$

Since the output register is initialized to $ket(0)_n$, when $ubs(U)_f$ is applied to this state the result is
$
    ubs(U)_f ubs(H)^(times.circle n) ket(0)_n ket(0)_n = frac(1, sqrt(2^n))sum_(x = 0)^(2^n - 1)ket(x)ket(f(x))
$

$ubs(U)_f$ has entangled the input and the output register. If we now measure the output register, the input register collapses into this state:
$
    frac(1, sqrt(2))(ket(x_0)_n + ket(x_0 plus.circle a)_n)
$
for some $x_0$. This is because the outcome of the measurement $f(x_0)$ is associated to two input values, which are indeed $x_0$ and $x_0 plus.circle a$, since $f$ is periodic.

#highlight(fill: yellow)[We can't measure the input register yet], because the possible outcomes $x_0$ and $x_0 plus.circle a$ would be indistinguishable for us, and therefore we would not be able to determine $a$.

So we apply another $ubs(H)^(times.circle n)$ to this state:
$
    ubs(H)^(times.circle n)(ket(x_0) + ket(x_0 + a)) & = frac(1, sqrt(2^(n + 1)))sum_(y = 0)^(2^n - 1)[(-1)^(x_0 dot y) + (-1)^((x_0 plus.circle a) dot y)]ket(y) \
    & = frac(1, sqrt(2^(n + 1)))sum_(y = 0)^(2^n - 1)[(-1)^(x_0 dot y) + (-1)^(x_0 dot y)(-1)^(a dot y)]ket(y)
$

From this we notice that the coefficient for $ket(y)$ is 0 if $a dot y = 1$, because in the sum we would have $(-1)^(x_0 dot y) - (-1)^(x_0 dot y)$. If instead $a dot y = 0$, the coefficient for $ket(y)$ is $2(-1)^(x_0 dot y)$.

So we can rewrite the expression above ignoring the cases of $a dot y = 1$:
$
    ubs(H)^(times.circle n)(ket(x_0) + ket(x_0 + a)) & = frac(1, sqrt(2^(cancel(n + 1))))cancel(2)sum_(a dot y = 0)(-1)^(x_0 dot y)ket(y) \
    & = frac(1, sqrt(2^(n - 1)))sum_(a dot y = 0)(-1)^(x_0 dot y)ket(y)
$

If we now measure the input register $ket(y)$ we get a random $y$ such that $a dot y = 0 <=> sum_(i = 0)^(n - 1)a_i y_i = 0$ (the equivalence applies because $a$ and $y$ are $n$-bit numbers). In particular, a single evaluation of $ubs(U)_f$ can rule out *half* of the possibilites for $a$, so we are left with $2^(n - 1) -1$ possibilites.

If we run the procedure again, we get another random $y'$ which further rules out half of the possibilites for $a$, leaving only $2^(n - 2) - 1$ possibilites and so on.

We should also consider the case when the algorithm returns $y = 0_n$, which does not give any clue about $a$. However, this is not a big deal because the probability of getting $y = 0$ is very small ($frac(1, 2^n - 1)$). Even if we got $y = 0$, by simply try again the algorithm there is a high probability that we get another $y$.

== Example

#figure(
    table(
        stroke: none,
        columns: (auto, auto),
        align: (top + center, top + center),
        [
            #table(
                columns: (auto, auto, auto),
                align: (center + horizon, center + horizon, center + horizon),
                [$ x $], [$ x plus.circle a $], [$ y = f(x) $],
                [000], [101], [001],
                [001], [100], [010],
                [010], [111], [100],
                [011], [110], [110],
                [100], [001], [010],
                [101], [000], [001],
                [110], [011], [110],
                [111], [010], [100]
            )
        ], [
            #table(
                columns: (auto, auto, auto),
                align: (center + horizon, center + horizon, left + horizon),
                [$ y $], [$ y dot a $], [*can be returned by the algorithm*],
                [001], [1], [no],
                [010], [0], [yes],
                [100], [1], [no],
                [110], [1], [no]
            )
        ]
    ),
    caption: [Example of an $f$ with $n = 3$ and $a = (101)_2$. Note that values in the $f(x)$ columns are random, but they respect the property that $f(x plus.circle a) = f(x)$.]
)

The procedure ends immediately in this case, because with a single evaluation of $ubs(U)_f$ we have ruled out all the possibilites for $a$.

Since we got $f(x) = 010_2$ for both $x_1 = 001_2$ and $x_2 = 100$, $a = 001_2 plus.circle 100_2 = 101_2$.

= Bell states

These are 4 foundamental entangled states:
$
    ket(psi_(00)) = frac(1, sqrt(2))(ket(00) + ket(11)) equiv ket(phi.alt^+) quad quad ket(psi_(10)) = frac(1, sqrt(2))(ket(00) - ket(11)) equiv ket(phi.alt^-) \
    ket(psi_(01)) = frac(1, sqrt(2))(ket(01) + ket(10)) equiv ket(Psi^+) quad quad  ket(psi_(11)) = frac(1, sqrt(2))(ket(01) - ket(10)) equiv ket(Psi^-)
$

The *amount of entanglement* (e.g. the Von Neumann entropy) is the same in all of these states.

These states are accomunated by the fact that they are a linear superposition between a 2-qubit state and its flipper variant (e.g. $ket(00) arrow.r ket(11)$ and $ket(01) arrow.r ket(10)$).

The Bell states define a complete basis for the two qubit states. In other words, a 2-qubit state can be rewritten as a linear combination of Bell states:
$
    ket(00) = frac(1, sqrt(2))(ket(psi_00) + ket(psi_10)) quad quad ket(10) = frac(1, sqrt(2))(ket(psi_01) - ket(psi_11)) \
    ket(01) = frac(1, sqrt(2))(ket(psi_01) + ket(psi_11)) quad quad ket(11) = frac(1, sqrt(2))(ket(psi_00) - ket(psi_10))
$

== Single qubit properties of the Bell states

#highlight(fill: yellow)[The Bell states are indistinguishable at a single qubit level]. This is a very important property, because it means that if noise affects *locally* a qubit encoded using a Bell state, then the information held by that qubit is not destroyed.

Indeed, if one of the Pauli gates ${ubs(X), ubs(Y), ubs(Z)}$ is applied either to qubit $A$ or qubit $B$ of a Bell state, the result is always the same for all the gates:
$
    bra(psi_00)ubs(X)_A times.circle ubs(I)_B ket(psi_00) = frac(1, 2)(bra(00) + bra(11))(ket(10) + ket(01)) = 0 \
    bra(psi_00)ubs(Y)_A times.circle ubs(I)_B ket(psi_00) = frac(i, 2)(bra(00) + bra(11))(ket(10) - ket(01)) = 0 \
    bra(psi_00)ubs(Z)_A times.circle ubs(I)_B ket(psi_00) = frac(1, 2)(bra(00) + bra(11))(ket(00) - ket(11)) = 0
$

#figure(
    table(
        columns: (auto, auto, auto, auto),
        align: (center + horizon, center + horizon, center + horizon, center + horizon),
        [], [$expval(X_(A\/B))$], [$expval(Y_(A\/B))$], [$expval(Z_(A\/B))$],
        [$ket(psi_00)$], [0], [0], [0],
        [$ket(psi_01)$], [0], [0], [0],
        [$ket(psi_10)$], [0], [0], [0],
        [$ket(psi_11)$], [0], [0], [0]
    ),
    caption: [Expected value of a single-qubit measurement of a Bell state after applying a Pauli gate on it. #highlight(fill: yellow)[All expected values are the same for each Bell state, so they are not distinguishable at single-qubit level.]]
)

#pagebreak(weak: true)
They are however distinguishable at 2-qubit level, because each Bell state has its own set of expected values:
#figure(
    table(
        columns: (auto, auto, auto, auto),
        align: (center + horizon, center + horizon, center + horizon, center + horizon),
        [], [$expval(ubs(X)_A times.circle ubs(X)_B)$], [$expval(ubs(Y)_A times.circle ubs(Y)_B)$], [$expval(ubs(Z)_A times.circle ubs(Z)_B)$],
        [$ket(psi_00)$], [$+1$], [$-1$], [$+1$],
        [$ket(psi_01)$], [$+1$], [$-1$], [$-1$],
        [$ket(psi_10)$], [$-1$], [$+1$], [$+1$],
        [$ket(psi_11)$], [$-1$], [$+1$], [$-1$]
    ),
    caption: [Expected value of a 2-qubit measurement of a Bell state after applying a Pauli gate on each of its 2 qubits]
)

=== Side note: uncorrelated and correlated measurements

In the first case, we performed an *uncorrelated measurement*: we measured each qubit of the Bell state *independently*, so we got 2 distinct results.

In the second case, we performed a *correlated measurement*: we measured the two qubits of the Bell state *jointly*, thus we get a *single* result which only specifies their relative state.

== Generating Bell states

The Bell states can be obtained by taking an initial basis state and then applying a CNOT preceded by an Hadamard applied to the control qubit:
$
    ket(psi_(x_1 x_0)) = ubs(C)_10 ubs(H)_1 ket(x_1 x_0) = frac(1, sqrt(2))(ket(0\, x_0) + (-1)^(x_1) ket(1\, x_0 plus.circle 1))
$

#highlight(fill: yellow)[This process is reversible]: we can get back $ket(x_1 x_0)$ by applying the operators in reverse order to $ket(psi_(x_1 x_0))$:
$
    ubs(H)_1 ubs(C)_10 ket(psi_00) = frac(1, 2)(ket(00) + ket(10) + ket(00) - ket(10)) = ket(00)
$

This should be not suprising, since $ubs(H)^2 = ubs(I)$ and $ubs(C)_10^2 = ubs(I)$:
$
    ubs(H)_1 ubs(C)_10 ket(psi_00) = ubs(H)_1 cancel((ubs(C)_10 ubs(C)_10))ubs(H)_1 ket(00) = cancel(ubs(H)_1 ubs(H_1))ket(00) = ket(00)
$

== Rotation of Bell states

#highlight(fill: yellow)[A Bell state can be *rotated* into another Bell state by applying two single-qubit gates]:
$
    ket(psi_(x_1 x_0)) = ubs(Z)_1^(x_1)ubs(X)_0^(x_0)ket(psi_00) = ubs(X)_0^(x_0)ubs(Z)_0^(x_1)ket(psi_00)
$

== Dense coding

#highlight(fill: yellow)[A qubit state holds an *infinite* amount of information], because its coefficient can be any number in $CC$, but when we measure a qubit we can only extract a *single* bit of information.

However, if we use *entanglement* as a resource, there is a way we can obtain *two* bits of information. This is known as *dense coding*.

This protocol consists in 4 steps:
1. Alice and Bob share two qubits in a Bell state, for example $ket(psi_00)$;
2. Alice applies to her qubit one of 4 transformations ($ubs(1), ubs(X), ubs(Z), ubs(Z X)$), depending on which set of bit she wants to communicate:

#figure(
    table(
        columns: (auto, auto),
        align: (center + horizon, center + horizon),
        [`00`], [$ ubs(1)_A ket(psi_00) = ket(psi_00) $],
        [`01`], [$ ubs(X)_A ket(psi_00) = frac(1, sqrt(2))(ket(10) + ket(01)) $],
        [`10`], [$ ubs(Z)_A ket(psi_00) = frac(1, sqrt(2))(ket(00) - ket(11)) $],
        [`11`], [$ ubs(Z)_A ubs(X)_A ket(psi_00) = frac(1, sqrt(2))(ket(01) - ket(10)) $]
    ),
    caption: [Transformation Alice must apply to her qubit based on the set of bits she wants to communicate]
)

3. Alice sends her qubit to Bob;
4. Bob, which has a Bell state (shared with Alice), reverses it to a basis state, e.g. it first applies a CNOT on the Bell state (using Alice's qubit $A$ as target) and then an Hadamadrd on qubit $A$;
5. the basis state Bob gets after step 4 is the set of bits Alice communicated

== Circuit representation

If Alice has two qubits $ket(x)$ and $ket(y)$ and she wants to send them to Bob, the circuit can be modeled using 2 CNOT gates:
#figure(
    image("assets/b2eba2f29d9d2053667f7a548bfeb18e.png", height: 13%),
    caption: [Step a: minimal circuit to send a basis state to Bob]
)

Although this circuit is very simple, it does not show at all the dense coding protocol. But we can rewrite this circuit to make the protocol evident.

#figure(
    image("assets/467681dd262186a70650808cf296925a.png", height: 13%),
    caption: [Step b: using the relation $ubs(X) = ubs(H Z H)$ to replace $ubs(C)_31$ with $ubs(H)ubs(Z)_31 ubs(H)$]
)

#figure(
    image("assets/defecc62ea7a940e426889ed6cabe7bf.png", height: 13%),
    caption: [Step c: inserting $(ubs(C)_10)^2 = ubs(1)_10$ and exploiting the commutation between $ubs(C)_10$ and $ubs(C)_31$]
)

#pagebreak(weak: true)
#figure(
    image("assets/3e090243c16b91e8936ec69a8e607a10.png", height: 13%),
    caption: [Step d: moving $ubs(H)_1$ and $ubs(C)_10$ to the extreme left by exploiting the commucation between $ubs(C)_20$ and $ubs(H)_1 ubs(C)_10$]
)

Next we can expand the 2 $ubs(C)$ gates on the left with 3 $ubs(C)$ gates:
#figure(
    image("assets/603a387c727d7ddfa6a4ff0d6e200bed.png", height: 13%),
    caption: [Step e: replacing $ubs(C)_20 ubs(C)_10$ with $ubs(C)_21 ubs(C)_10 ubs(C)_21$]
)

The effect is the same:
$
    & ubs(C)_20 ubs(C)_10 ket(x_2\, x_1\, x_0) = ubs(C)_21 ubs(C)_10 ubs(C)_21 ket(x_2\, x_1\, x_0) \
    --> & ubs(C)_20 ket(x_2\, x_1\, x_0 plus.circle x_1) = ubs(C)_21 ubs(C)_10 ket(x_2\, x_1 plus.circle x_2\, x_0) \
    --> & ket(x_2\, x_1\, x_0 plus.circle x_1 plus.circle x_2) = ubs(C)_21 ket(x_2\, x_1 plus.circle x_2\, x_0 plus.circle x_1 plus.circle x_2) \
    --> & ket(x_2\, x_1\, x_0 plus.circle x_2 plus.circle x_2) = ket(x_2\, x_1 cancel(plus.circle x_2) cancel(plus.circle x_2)\, x_0 plus.circle x_1 plus.circle x_2)
$

Finally, we can remove the leftmost $ubs(C)_21$ because $ubs(X H)ket(0) = frac(1, sqrt(2))ubs(X)(ket(0) + ket(1)) = frac(1, sqrt(2))(ket(0) + ket(1))$:
#figure(
    image("assets/b4930f06b5f1c138a10193d1dda0562b.png", height: 13%),
    caption: [Step f: removing $ubs(C)_21$ because it acts as an identity]
)

Indeed:
$
    underbrace(mat(0, 1; 1, 0), ubs(X))underbrace(frac(1, sqrt(2))mat(1, 1; 1, -1), ubs(H))underbrace(vec(1, 0), ket(0)) = frac(1, sqrt(2))mat(0, 1; 1, 0)vec(1, 1)
    = frac(1, sqrt(2))vec(1, 1) = ubs(H)ket(0)
$

#pagebreak(weak: true)
= Bloch sphere

#figure(
    image("assets/223635fd0ad1b7e3ecd71d83d119a498.png", height: 17%),
    caption: [Bloch sphere]
)

#highlight(fill: yellow)[Each *pure* state of the qubit corresponds to a point on the surface of the Bloch sphere].

Coefficients $alpha, beta in CC$ of state $ket(psi) = alpha ket(0) + beta ket(1)$ can be rewritten as $alpha = cos theta/2$ and $beta = e^(i phi) sin theta/2$, so $ket(psi)$ can be rewritten as:
$
    ket(psi) = cos(frac(theta, 2))ket(0) + e^(i phi)sin(frac(theta, 2))ket(1) quad quad theta in [0, pi] quad phi in [0, 2pi]
$

The coordinates of a quantum state in the Bloch sphere are given by this relation:
$
    ubs(r) = (sin theta cos phi, sin theta sin phi, cos theta) <=> (braket(psi, ubs(X), psi), braket(psi, ubs(Y), psi), braket(psi, ubs(Z), psi))
$

Points *inside* the sphere have a meaning too: they represent a *mixture of states*.

The distance from the center of the sphere of the quantum state is related to the Von Neumann entropy: the higher the distance, the lower the entropy.

Quantum gates represent a *rotation* of this sphere, e.g. the $ubs(X)$ gate represents a rotation of $pi$.

Bloch sphere is useful to show single qubit properties, but it's useless to discriminate between different entangled states.

If we have an unknown qubit state:
$
    ket(psi) = alpha ket(0) + beta ket(1) = frac(1, sqrt(2))[(alpha + beta)ket(+) + (alpha - beta)ket(-)]
$
and we measure it as is, we get information only for one of its 3 components (the $z$ component). To get information on other components, we must *rotate* the state first (e.g. by applying an Hadamard), measure it, and rotate it back again.

= Quantum teleportation

*Problem*: Alice has a single copy of an unknown quantum state $ket(psi) = alpha ket(0) + beta ket(1)$ and she wants to send it to Bob.

Alice cannot physically send the qubit to Bob. She also cannot measure it to determine its state (Born rule) nor copy it (no cloning theorem).

#highlight(fill: yellow)[The protocol for quantum teleportation is somewhat the inverse of the dense coding protocol]:
- with the dense coding protocol, Alice communicates 2 bits of information by sending a single-qubit state to Bob;
- with the quantum teleportation protocol, Alice communicates an unknown single-qubit state by sending 2 bits of information to Bob

The protocol consists in 4 steps:
1. Alice and Bob share an entangled state, e.g. the Bell state $ket(psi_00)$. Considering Alice's 2 qubits and Bob's 1 qubit (total amount of 3 qubit), the quantum system is in the state $ket(Phi_1)$:
$
    ket(Phi_1) = ket(psi)_A ket(psi_00)_(A B) & = (alpha ket(0)_A + beta ket(1)_A)frac(1, sqrt(2))(ket(00)_(A B) + ket(11)_(A B)) \
    & = frac(1, sqrt(2))[alpha ket(0)_A (ket(00)_(A B) + ket(11)_(A B)) + beta ket(1)_A (ket(00)_(A B) + ket(11)_(A B))]
$

2. Alice applies a CNOT to her two qubits. The qubit whose state has to be communicated acts as the control qubit:
$
    ket(Phi_2) = ubs(C)_21 ket(Phi_1) = frac(1, sqrt(2))[alpha ket(0)_A (ket(#text(fill: green)[0]0)_(A B) + ket(#text(fill: green)[1]1)_(A B)) + beta ket(1)_A (ket(#text(fill: red)[1]0)_(A B) + ket(#text(fill: red)[0]1)_(A B))]
$

$ubs(C)_21$ has flipped the qubits highlighted in #text(fill: red)[*red*], but it left untouched the qubits highlighted in #text(fill: green)[*green*] because the control qubit has value 0.

3. Alice applies an Hadamard gate to the qubit whose state has to be communicated:
$
    ket(Phi_3) = ubs(H)_3 ket(Phi_2) = frac(1, 2)[alpha (ket(0)_A + ket(1)_A)(ket(00)_(A B) + ket(11)_(A B)) + beta(ket(0)_A - ket(1)_B)(ket(10)_(A B) + ket(01)_(A B))]
$

4. Alice measures her two qubits and communicates the outcome to Bob. Let's rewrite state $ket(Phi_3)$ to make the possible outcomes for Alice and Bob clearer:
$
    ket(Phi_3) & = frac(1, 2)[ket(00)_(A A)(alpha ket(0)_B + beta ket(1)_B) + ket(10)_(A A)(alpha ket(0)_B - beta ket(1)_B) \
    & + ket(01)_(A A)(alpha ket(1)_B + beta ket(0)_B) + ket(11)_(A A)(alpha ket(1)_B - beta ket(0)_B)]
$

5. Bob applies some gates to his qubit. The gates he has to apply are determined by Alice's measurement outcome:
#figure(
    table(
        columns: (auto, auto, auto),
        [*outcome for Alice*], [*Bob qubit state*], [*what Bob has to do to get $ket(psi)$*],
        [`00`], [$alpha ket(0) + beta ket(1)$], [nothing, Bob already has its qubits in state $ket(psi)$],
        [`01`], [$alpha ket(1) + beta ket(0)$], [Bob has to apply $ubs(X)$],
        [`10`], [$alpha ket(0) - beta ket(1)$], [Bob has to apply $ubs(Z)$],
        [`11`], [$alpha ket(1) - beta ket(0)$], [Bob has to apply $ubs(Z X)$]
    ),
    caption: [What Bob has to do to get $ket(psi)$ based on the outcome of Alice's measurement]
)

#highlight(fill: yellow)[Quantum teleportation does not violate the no cloning theorem]: at the end of the process, Alice is left with the state $ket(x_1 x_0) times.circle ket(psi_00)$ (where $x_1, x_0$ are the outcome of her measurement). She loses all information about the original, unknown state $ket(psi)$.

== A qubit can be looked from different perspectives

#highlight(fill: yellow)[This is what allows quantum teleportation].

State $ket(Phi_1)$ can be rewritten using the Bell states as basis states:
$
    ket(Phi_1) = ket(psi)_A ket(psi_00)_(A B) = frac(1, sqrt(2))(alpha ket(000)_(A A B) + beta ket(100)_(A A B) + alpha ket(011)_(A A B) + beta ket(111)_(A A B)) \
    = frac(1, 2)[ket(psi_00)_(A A)(alpha ket(0)_B + beta ket(1)_B) + ket(psi_01)_(A A)(alpha ket(1)_B + beta ket(0)_B) \+ ket(psi_10)_(A A)(alpha ket(0)_B - beta ket(1)_B) + ket(psi_11)(alpha ket(1)_B - beta ket(0)_B)]
$

By looking at $ket(Phi_1)$ rewritten in this way, it's clear that the next operations Alice does (a CNOT followed by an Hadamard) produce a *rotation* of this state; the information contained in these qubits is not altered in any way.

== Circuit representation

The goal is to transfer an unknown state from the first qubit to the second one.

#figure(
    image("assets/c59eef996428afc2b2e3c897ccb49968.png", height: 8%),
    caption: [Step a: quantum circuit that transfers a generic single-qubit state $ket(psi)$ to $ket(0)$]
)

This circuit, despite being very simple, does not implement the quantum teleportation protocol, also because quantum teleportation communicate a *linear superposition* of states, but this circuit communicates only a single basis state.

We therefore introduce an ancillar qubit $ket(phi.alt)$ initialized to $ubs(H)ket(0)$:
#figure(
    image("assets/79bc63b583bad2f0693a1f6827f514ca.png", height: 8%),
    caption: [Step b: introduction of $ket(phi.alt) = ubs(H)ket(0)$]
)

Similar to what done in the circuit derivation for the dense coding protocol, we substitue $ubs(C)_20$ with a controlled $ubs(Z)$ gate. We also add $ubs(C)_21$ because it acts like an identity for $ket(phi.alt) = ubs(H)ket(0)$, because $ubs(X H)ket(0) = ubs(H)ket(0)$:
#figure(
    image("assets/30b4a2651c695c1ae02017ba92262451.png", height: 8%),
    caption: [Step c: using $ubs(C)_02 = ubs(H)_2 ubs(Z)_02 ubs(H)_2$ and $ubs(X H)ket(0) = ubs(H)ket(0)$ identities to rewrite the circuit]
)

#figure(
    image("assets/7bfcd50e7f65d814d21870a98e11a4d5.png", height: 8%),
    caption: [Step d: flipping target and control qubits of $ubs(Z)_02$ and exploiting the equivalence $ubs(C)_20 ubs(C)_21 = ubs(C)_10 ubs(C)_21 ubs(C)_10$]
)

#figure(
    image("assets/94254b6044694a7d21cf7bc0c819cc31.png", height: 8%),
    caption: [Step e: adding $ubs(H)_1$ and replacing $ubs(C)_10 ubs(H)_2$ with $ubs(H)_2 ubs(C)_10$ because they commute with each other]
)

#figure(
    image("assets/948e5f7065d1c6f3b7a47a572ad33c82.png", height: 8%),
    caption: [Step f: adding $ubs(M)_2$ and $ubs(M)_1$]
)

#figure(
    image("assets/ee748397b4b7e1b999e0a18c18430694.png", height: 8%),
    caption: [Step g: swapping $ubs(M)_2$ and $ubs(M)_1$ with $ubs(C)_10 ubs(Z)_20$ because they commute with each other]
)

This last circuit represents the quantum teleportation protocol.

= Quantum cryptography

Quantum cryptography works quite differently from non-quantum modern cryptography:
- non-quantum *asymmetric* cryptography is based on *hard problems*, i.e. problems that require a high amount of computing power to be solved. If someday there will be enough computing power, this type of cryptography will be broken;
- quantum cryptography instead is based on properties of quantum systems, i.e. on *laws of nature*. Computing power is irrelevant here.

Quantum cryptography is possible by exploiting some properties of quantum systems which may be annoying in other contexts:
- no cloning theorem: Eve cannot store a copy of the eavesdropped quantum state and then try to decrypt it, because a quantum state cannot be cloned;
- measurement destroys the original state: if Eve tries to scramble with the qubit state, Alice and Bob will notice it;
- measurement outcome is *random*. Quantum systems are *truly random*, not just pseudo-random like classical systems, therefore they can never be *predicted*

== BB84 protocol (Bennet-Brassard)

This protocol actually is a *key-exchange protocol*. Alice has a sequence $S$ of random bits and wants to send it to Bob, so they can use $S$ as the key for a *symmetric encryption* scheme.

The protocol starts with Alice preparing a sequence of qubits that will form the *shared secret key* when the outcomes of the measurements of each qubit will be put together. #highlight(fill: yellow)[For each qubit, Alice chooses *randomly* in which state preparing it between 4 alternatives]: ${ket(0), ket(1), ket(+), ket(-)}$. In other words, she decides randomly the *basis* in which the qubit will be prepared:
- type-1 qubit (basis ${ket(0), ket(1)}$);
- type-H qubit (basis ${ket(+), ket(-)} = {ubs(H)ket(0), ubs(H)ket(1)}$)

Alice then sends each qubit to Bob, which will perform a similar choice for each qubit: he will choose *randomly* whether
- measuring the qubit immediately (type-1 measurement);
- measuring the qubit only after applying an Hadamard on it (type-H measurement)

Alice and Bob then communicate over an *insecure* channel the type of their qubits and they discard the qubits which are not of the same type. They do not communicate the exact state of the qubit (and they must not to if they want the protocol to be secure!), but only the type.

The sequence of bits that survives is the shared secret key, but before using it Alice and Bob must check for *eavesdroppers*. Alice and Bob choose an arbitrary number of qubits to check (the higher, the more secure, but also the slower): if in these qubits Bob finds a state which does not match with the type of qubit sent by Alice, it means that the shared key has been eavesdropped and therefore it's not secure.\
Example: if Alice sents a qubit in the basis ${ket(+), ket(-)}$ and Eve measures it using a type-1 measurement before forwarding the qubit to Bob, the qubit will change the basis to ${ket(0), ket(1)}$. When Bob applies an Hadamard to it, the state will remain in that basis and therefore it will not match with the basis Alice prepared the qubit in.

= Grover algorithm

== Preliminary notions

=== Vector space and dual space

#figure(
    image("assets/0fb5efd267965972fb56ccf1ca4b34e6.png", width: 50%),
    caption: [Vector space and dual space representation. Our qubits can be represented in one of these two spaces.]
)

The *inner product* $braket(alpha, beta)$ is a complex number which is the #highlight(fill: yellow)[measurement of the *overlap* between the two vectors].

The *outer product* $ketbra(beta, alpha)$ is an *operator* that when applied to a state $ket(psi)$ gives $braket(alpha, psi)ket(beta)$ and when applied to $bra(psi)$ gives $braket(psi, beta)ket(alpha)$.

=== Projector

A projector $ubs(P)$ is an Hermitian and *idempotent* operator (i.e. $ubs(P)^2 = ubs(P)$) that can be written as $ubs(P) = ketbra(lambda, lambda)$.

The *eigenvalues* of a projector operator $ubs(P)$ corresponds to 0 or 1, because the operator is idempotent:
$
    ubs(P)ket(lambda) = lambda ket(lambda) = ubs(P)^2 ket(lambda) = lambda^2 ket(lambda) <=> lambda in {0, 1}
$

One might note that the *density matrix* is also defined as $rho = ketbra(psi, psi)$. Projectors and density matrices are different things conceptually, but if $ket(psi)$ is a *pure state* (and not a *mixture* of states), then the projector and the density matrix are equivalent.\
#highlight(fill: yellow)[In general, if we have a pure quantum state, we can say that the projector is actually a *density operator*].

== Grover algorithm

The problem is to search for an item $a$ in an *unsorted database* of size $N$. We have a function $f : {0, 1}^n |-> {0, 1}$ that acts like an *oracle*, i.e. it says if $x = a$:
$
    f(x) = cases(
        0 "if" x != a,
        1 "if" x = a
    )
$

The computational cost of this algorithm is the number of times $f$ has to be evaluated before finding a value $x_k = a$.

In a classical approach, the average cost is $Order(N / 2) = Order(2^(n - 1))$ for $n$ bits (i.e. *exponential cost* in the number of bits).

The average cost for the quantum approach instead is $Order(sqrt(N)) = Order(2^(n / 2))$. This cost is still exponential, but it's significantly lower than the classical approach.

The first step is to define $ubs(U)_f$ in the usual way, i.e. $ubs(U)_f (ket(x)_n ket(y)_n) = ket(x)_n ket(y plus.circle f(x))_n$.

#pagebreak(weak: true)
Our problem can be represented using this circuit:
#figure(
    image("assets/76e4360feeff87e9d3f210e99d1c32d8.png", height: 20%),
    caption: [Circuit representation of the Grover algorithm, a *multi-controlled* $ubs(X)$ gate.]
)

We initialize the output register in the state $ubs(H)ket(1) = frac(1, sqrt(2))(ket(0) - ket(1)) = ket(-)$, so the operator $ubs(U)_f$ can be rewritten in this way:
$
    ubs(U)_f (ket(x)_n times.circle ket(-)) = ket(x)_n times.circle [(-1)^(f(x))ket(-)] = [(-1)^(f(x))ket(x)_n] times.circle ket(-)
$

In the second step we moved $(-1)^(f(x))$ to the left, which is always possible due to *linearity* of quantum mechanics. Written in this form, we notice that $f(x)$ is acting on the *input* register only; the output register is left untouched in the state $ket(-)$.

So we can ignore the output register and rephrase the problem in terms of a unitary transformation $ubs(V)$ acting con the input space alone:
$
    ubs(V)ket(x) = (-1)^(f(x))ket(x) = cases(ket(x) "if" x != a, -ket(a) "if" x = a) = ubs(1) - 2ketbra(a)
$

In other words, $ubs(V)$ is the *projector operator* on state $ket(a)$.

The next step is to initialize the input qubits in a linear superposition of all the basis states, with equal weights:
$
    ket(phi.alt) = ubs(H)^(times.circle n)ket(0)_n = frac(1, sqrt(2^n))sum_(x = 0)^(2^n - 1)ket(x)_n
$
and then introducing another operator $ubs(W)$ that is the *projector operator* on state $ket(phi.alt)$ (and in particular it does not depend on the value of $a$):
$
    ubs(W) = 2ketbra(phi.alt) - ubs(1)
$

Operators $ubs(V)$ and $ubs(W)$ are *closed* in the vector space ${ket(a), ket(phi.alt)}$, because when they are applied to any vector, the result is a linear combination of $ket(phi.alt)$ and $ket(a)$:
#align(center)[
    #table(
        columns: (auto, auto),
        align: (center + horizon, center + horizon),
        stroke: none,
        [$ ubs(V)ket(a) = -ket(a) $], [$ ubs(W)ket(a) = frac(2, sqrt(2^n))ket(phi.alt) - ket(a) $],
        [$ ubs(V)ket(phi.alt) = ket(phi.alt) $], [$ ubs(W)ket(phi.alt) = ket(phi.alt) - frac(2, sqrt(2^n))ket(a) $]
    )
]

These relations are verified because $ket(phi.alt)$ is a linear superposition of all the possible input registers including $ket(a)$ itself, so the overlap between $ket(a)$ and $ket(phi.alt)$ is $2^(-frac(n, 2)) = frac(1, sqrt(N))$.

#pagebreak(weak: true)
This overlap between $ket(phi.alt)$ and $ket(a)$ is also the *cosine* of the angle $theta$ between these two vectors:
$
    cos theta = braket(a, phi.alt) = frac(1, sqrt(N)) -->_(n -> infinity) 0
$

This tells us that for a very big $N$, $ket(phi.alt)$ and $ket(a)$ are *nearly* orthogonal. However, we want a linear superposition which is *exactly* orthogonal to $ket(a)$, so we define the state $ket(a_perp)$ in this way:
$
    ket(a_perp) = frac(1, sqrt(2^n - 1))sum_(x != a)ket(x)
$

$ket(a_perp)$ is the linear superposition of all possible inputs *excluding* $a$ (and this is the reason why there is a $-1$ in the denominator in front of the sum).

Operator $ubs(V)$ represented in the basis ${ket(a), ket(a_perp)}$ is given by:
$
    ubs(V) = mat(
        braket(a, ubs(V), a), braket(a, ubs(V), a);
        braket(a_perp, ubs(V), a), braket(a_perp, ubs(V), a_perp)
    ) = mat(-1, 0; 0, 1)
$

In the last step we used the relation $ubs(V)ket(a) = (ubs(1) - 2ketbra(a))ket(a) = -ket(a)$, which implies that $braket(a, ubs(V), a) = -1$ and that $braket(a_perp, ubs(V), a) = 0$.

To get $ubs(W)$ we need to consider the operator $ketbra(phi.alt)$. First, let's rewrite $ket(phi.alt)$ in the basis ${ket(a), ket(a_perp)}$:
$
    ket(phi.alt) = frac(1, sqrt(N))(ket(a) + sqrt(N - 1)ket(a_perp))
$

From this we can obtain $ketbra(phi.alt)$ much like we obtained $ubs(V)$:
$
    ketbra(phi.alt) = mat(
        braket(a, ketbra(phi.alt), a), braket(a, ketbra(phi.alt), a_perp);
        braket(a_perp, ketbra(phi.alt), a), braket(a_perp, ketbra(phi.alt), a_perp)
    ) = frac(1, N)mat(
        1, sqrt(N - 1);
        sqrt(N - 1), N - 1
    )
$
and then we can get $ubs(W) = 2ketbra(phi.alt) - ubs(1)$:
$
    ubs(W) = frac(1, N)mat(
        2 - N, 2sqrt(N - 1);
        2sqrt(N - 1), N - 2
    )
$

Now we can define the *Grover operator* $ubs(W V)$:
$
    ubs(W V) = underbrace(frac(1, N)mat(2 - N, 2sqrt(N - 1); -2sqrt(N - 1), N - 2), ubs(W))underbrace(mat(-1, 0; 0, 1), ubs(V)) = frac(1, N)mat(
        N - 2, 2sqrt(N - 1);
        -2sqrt(N - 1), N - 2
    )
$

#pagebreak(weak: true)
== Geometric interpretation

#highlight(fill: yellow)[Two quantum states are *orthogonal* if the angle $theta$ between them is $pi$. In this context _perpendicular_ and _orthogonal_ are not synonyms: to be orthogonal, the vectors must point in *opposite* directions].

#figure(
    image("assets/3c207846ae998e3c237c14cde7624e42.png", height: 20%),
    caption: [A plane with the geometric interpretation of the Grover algorithm]
)

The input register $ket(phi.alt)$ is very close to $ket(a_perp)$, because these two vectors are very similar:
- $ket(phi.alt)$ is the linear superposition of all possible $n$-qubit states *including* $ket(a)$;
- $ket(a_perp)$ is the linear superposition of all possible $n$-qubit states *excluding* $ket(a)$

The Grover operator $ubs(W V)$ actually *rotates* the vector $ket(phi.alt)$:
- $ubs(V)$ implements a reflection of $ket(psi) = ubs(W V)^k ket(phi.alt)$ along the $ket(a_perp)$ axis, corresponding to a clockwise rotation by an angle $2(alpha + beta)$ (where $alpha = arccos braket(a_perp, phi.alt)$ and $beta = arccos braket(phi.alt, psi)$);
- $ubs(W)$ implements a reflection of $ubs(V)ket(psi)$ along the $ket(phi.alt)$ axis, corresponding to a counterclockwise rotation by an angle of $2(2alpha + beta)$

The net effect is a rotation by an angle of $2(alpha + beta) - 2(2alpha + beta) = -2alpha$, i.e. a counterclockwise rotation of $gamma = 2alpha$. The value of $gamma$ can be retrieved by comparing the Grover operator with the generic *rotation operator* $ubs(R)_y (gamma)$:
$
    ubs(R)_y (gamma) = mat(cos(frac(gamma, 2)), sin(frac(gamma, 2)); -sin(frac(gamma, 2)), cos(frac(gamma, 2)))
$

Therefore the angle $gamma$ is given by:
$
    gamma = 2 arcsin(frac(2sqrt(N - 1), N)) tilde.eq 2arcsin(frac(2, sqrt(N))) tilde.eq frac(4, sqrt(N))
$

Since $ket(phi.alt)$ starts very close to $ket(a_perp)$ and the goal is to reach $ket(a)$, and every application of the Grover operator rotates counterclockwise $ket(psi)$ by an angle of $frac(4, sqrt(N))$, the number of required rotations is given by:
$
    R = frac(pi, frac(4, sqrt(N))) = frac(pi, 4)sqrt(N)
$

Since $R = Order(sqrt(N))$, this demonstrates why the Grover algorithm has an average cost of $Order(sqrt(N))$.

However, after all these rotations, we will not arrive *exactly* to $ket(a)$, but to another value $ket(overline(a))$ which is very close to $ket(a)$. The probability of arriving exactly to $ket(a)$ is given by:
$
    P >= cos^2(frac(alpha, 2)) = 1 - frac(1, N) -->_(n -> infinity) 1
$

If after $R$ rotation we land on a value $overline(a) != a$, the whole procedure must be tried again. If after a large (arbitrary) number of trials we still have not found $a$, then this means $a$ does not exist.

== Grover algorithm with two qubits

$ket(phi.alt)$ is the linear superposition of all possible input states:
$
    ket(phi.alt) = frac(1, 2)(ket(00) + ket(01) + ket(10) + ket(11)) = frac(1, 2)vec(1, 1, 1, 1)
$

Let's consider the case of $ket(a) = ket(01)$. We have:
$
    ubs(W) = 2ketbra(phi.alt) - ubs(1) = frac(1, 2)mat(-1, 1, 1, 1; 1, -1, 1, 1; 1, 1, -1, 1; 1, 1, 1, -1) quad quad ubs(V) = 1 - 2ketbra(a) = mat(1, 0, 0, 0; 0, -1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1) \
    ubs(W V) = frac(1, 2)mat(-1, -1, 1, 1; 1, 1, 1, 1; 1, -1, -1, 1; 1, -1, 1, -1)
$

In this case a single application of $ubs(W V)$ is enough to find the solution:
$
    ubs(W V)ket(phi.alt) = frac(1, 4)mat(-1, -1, 1, 1; 1, 1, 1, 1; 1, -1, -1, 1; 1, -1, 1, -1)vec(1, 1, 1, 1) = vec(0, 1, 0, 0) = ket(01)
$

Let's now switch to the basis ${ket(a), ket(a_perp)}$:
$
    ket(a_perp) = frac(1, sqrt(3))(ket(00) + ket(10) + ket(11)) = frac(1, sqrt(3))vec(1, 0, 1, 1) \
    ubs(W V)ket(a) = frac(1, 2)mat(-1, -1, 1, 1; 1, 1, 1, 1; 1, -1, -1, 1; 1, -1, 1, -1)vec(0, 1, 0, 0) = frac(1, 2)vec(-1, 1, -1, -1) quad quad ubs(W V)ket(a_perp) = frac(1, 2sqrt(3))mat(-1, -1, 1, 1; 1, 1, 1, 1; 1, -1, -1, 1; 1, -1, 1, -1)vec(1, 0, 1, 1) = frac(1, 2sqrt(3))vec(1, 3, 1, 1) \
    braket(a, ubs(W V), a) = frac(1, 2)mat(0, 1, 0, 0)vec(-1, 1, -1, -1) = frac(1, 2) quad quad braket(a_perp, ubs(W V), a) = frac(1, 2sqrt(3))mat(1, 0, 1, 1)vec(-1, 1, -1, -1) = -frac(sqrt(3), 2) \
    braket(a, ubs(W V), a_perp) = frac(1, 2sqrt(3))mat(0, 1, 0, 0)vec(1, 3, 1, 1) = frac(sqrt(3), 2) quad quad braket(a_perp, ubs(W V), a_perp) = frac(1, 6)mat(1, 0, 1, 1)vec(1, 3, 1, 1) = frac(1, 2) \
    ubs(W V) = frac(1, 2)mat(1, sqrt(3); -sqrt(3), 1) = ubs(R)_y (frac(2pi, 3))
$

$
    alpha = 2arccos braket(a_perp, phi.alt) = 2arccos(frac(sqrt(3), 2)) = frac(pi, 3) -> gamma = 2alpha = frac(2pi, 3)
$

== How to construct $ubs(W)$

In this section we will consider the gate $-ubs(W)$ instead of $ubs(W)$, because it's easier to implement and it still leads to a final state that differs only by a (harmless) minus sign.

Since $ubs(W) = 2ketbra(phi.alt) - ubs(1)$, it follows that $-ubs(W) = ubs(1) - 2ketbra(phi.alt)$. If we write $ket(phi.alt)$ explicitly we have:
$
    -ubs(W) & = ubs(H)^(times.circle n)(ubs(1) - 2ketbra(00 ... 00, 00 ... 00))ubs(H)^(times.circle n) \
    & = ubs(H)^(times.circle n)[ubs(X)^(times.circle n)(ubs(1) - 2ketbra(1...1))ubs(X)^(times.circle n)]ubs(H)^(times.circle n) \
    & = ubs(H)^(times.circle n)[ubs(X)^(times.circle n)(c^(n - 1)ubs(Z))ubs(X)^(times.circle n)]ubs(H)^(times.circle n)
$

The multi-qubit gate $c^(n - 1)ubs(Z)$, which is actually a multi-controlled $ubs(Z)$ gate, can be decomposed into a double-controlled $ubs(Z)$ gate ($c^2 ubs(Z)$) sandwitched between $2(n - 3)c^2 ubs(X)$ gates:
#figure(
    image("assets/c8b6a4949b1799b0f80328f7fe9f2239.png", height: 18%),
    caption: [Decomposition of $c^(n - 1)ubs(Z)$ in multiple 3-qubit gates]
)

This decomposition uses $n - 3$ ancillary qubits, all initialized in the state $ket(0)$.

== Generalization to the case of $m > 1$ special items

We assume there are *multiple* special items $a_1, ..., a_m$ in the database and we want to retrieve one of them (which one does not matter).

The problem does not change 

Our oracle changes in this way:
$
    f(x) = cases(
        0 "if" x in.not {a_1, ..., a_m},
        1 "if" x in {a_1, ..., a_m}
    )
$
but the problem does not changes conceptually with respect to the case of $m = 1$.

$ket(psi)$ changes with respect to the case $m = 1$ because there are *multiple* states to "remove" from the linear superposition, not just a single one:
$
    ket(psi) = frac(1, sqrt(m))sum_(k = 1)^(m)ket(a_k) quad quad ket(psi_perp) = frac(1, sqrt(N - m))sum_(x in.not {a_1, ..., a_m})ket(x)
$

Operator $ubs(V)$ is generalized as follows:
$
    ubs(V) = ubs(1) - frac(2, m)sum_(j = 1 \ k = 1)^(m) ketbra(a_j, a_k) = ubs(1) - 2ketbra(psi)
$

The angle $gamma$ now becomes $tilde.eq 4sqrt(frac(m, N))$. We reach this approximation because $N << m$, therefore $N - m tilde.eq N$. This angle $gamma$ is much bigger than the one for the case of $m = 1$, so the cost of the Grover operator is reduced.

However, the speedup from $m = 1$ to $m > 1$ is smaller in the quantum case than in the classical case:
- with a classical approach, the speedup is linear in $m$ (if there are multiple special items, it's easier to find one of them);
- with a quantum approach, the speedup is just of $sqrt(N)$

Anyway, the quantum version for $m > 1$ is more efficient than the quantum version for $m = 1$, because the presence of $m$ special items reduces the number of calls by a factor $sqrt(m)$.

= Quantum Fourier transform

We have a *periodic function* $f$ such that $f(x) = f(y) <=> x - y = k r$ for some integer $k$. Our goal is to find the period $r$.

The best known classical algorithm for finding $r$ scales as $root(3, n)$. The quantum version instead has a significant speedup of $n^3$.

The *discrete Fourier transform* is a function $cal(F): CC^N -> CC^N$:
$
    tilde(gamma)_x = frac(1, sqrt(N))sum_(y = 0)^(N - 1)gamma_y e^(-frac(2pi i x y, N))
$

To implement this function on a quantum computer, we can rephrase the problem in a transformation from the Hilbert space to itself. The *quantum Fourier transform* is the unitary transformation $ubs(U)_("FT")$ whose action on the computational basis is given by
$
    ubs(U)_("FT") ket(x)_n = frac(1, sqrt(2^n))sum_(y = 0)^(2^n - 1)e^(frac(2pi i x y, 2^n))ket(y)_n
$

$ubs(U)_("FT")$ is *unitary* because it preserves the inner product:
$
    braket(x, ubs(U)_("FT")^dagger ubs(U)_("FT"), x') = braket(x, x')
$

Another proof of the "unitaryness" of $ubs(U)_("FT")$ is that we will construct it out of 1- and 2-qubit unitary gates.

$ubs(U)_("FT")$ implements the discrete Fourier transform on the $N$ complex numbers that correspond to the coefficients of the state $ket(psi)$.

The classical fast Fourier transform requres $Order(n 2^n)$ steps, while the quantum version requires just $Order(n^2)$ steps (#highlight(fill: yellow)[exponential vs polynomial]).

The major drawback of the quantum version is that we cannot retrieve all the Fourier coefficients $tilde(gamma)$, but if $gamma$ is a periodic function (with a period $<= sqrt(2^n)$), then the quantum version can give powerful clues about the value of the period $r$.

To construct a circuit to execute the quantum Fourier transform $ubs(U)_("FT")$, it's convenient to introduce an $n$-qubit operator $cal(bold(Z))$:
$
    cal(bold(Z))ket(y)n = e^(frac(2pi i y, 2^n))ket(y)
$

This $cal(bold(Z)))$ is the generalization to $n$-qubit of the 1-qubit $ubs(Z)$ operator. It is used to add a *phase* to every state of the linear superposition generated by the $ubs(H)^(times.circle n)$ operator.

This $cal(bold(Z))$ operator can be written as an *exponential function* of the single-qubit number operators:
$
    & y = y_(k - 1)2^(k - 1) + ... + y_0 2^0 \
    --> & hat(y) = ubs(n)_(k - 1)2^(k - 1) + ... + ubs(n)_0 2^0 \
    --> & cal(bold(Z)) = exp[frac(2i pi, 2^k)(ubs(n)_(k - 1)2^(k - 1) + ... + ubs(n)_0 2^0)]
$

By using this $cal(bold(Z))$ operator, we can rephrase the definition of $ubs(U)_("FT")$:
$
    ubs(U)_("FT")ket(x) = cal(bold(Z))^x ubs(H)^(times.circle n)ket(0)_n
$

This gives $ubs(U)_("FT")ket(x)_n$ as an $x$-dependent operator acting on the state $ket(0)$. This operator is quite odd, because it depends on its input $x$. Therefore the goal now is to rewrite this expression to obtain an $x$-independent operator acting on the state $ket(x)_n$.

== Four qubit example

When $k = n = 4$, the QFT expression can be rewritten as
$
    ubs(U)_("FT")ket(x_3)ket(x_2)ket(x_1)ket(x_0) = cal(bold(Z))^x ubs(H)_3 ubs(H)_2 ubs(H)_1 ubs(H)_0 ket(0)ket(0)ket(0)ket(0)
$

Expression for $cal(bold(Z))$ for $n = 4$ can be retrieved by its general form:
$
    & cal(bold(Z)) = exp[frac(i pi, 8)(8ubs(n)_3 + 4ubs(n)_2 + 2ubs(n)_1 + ubs(n)_0)] \
    --> & cal(bold(Z))^x = exp[frac(i pi, 8)(8ubs(n)_3 + 4ubs(n)_2 + 2ubs(n)_1 + ubs(n)_0)(8x_3 + 4x_2 + 2x_1 + x_0)]
$

This expression for $cal(bold(Z))^x$ is quite long (16 terms), but it can be simplified.

The first simplification comes from the fact that $e^(2pi i ubs(n)) = ubs(1)$:
$
    e^(2pi i ubs(n)) = cases(
        e^((2i pi) dot 0) = (-1)^0 = 1 "for" ubs(n)ket(0) = 0,
        e^((2i pi) dot 1) = (-1)^2 = 1 "for" ubs(n)ket(1) = 1
    )
$
therefore all products $x_i ubs(n)_j$ whose coefficient is $> 2^(n - 1)$ can be dropped, leaving
$
    cal(bold(Z))^x = exp{[x_0 ubs(n)_3 + (x_1 + frac(x_0, 2))ubs(n)_2 + (x_2 + frac(x_1, 2) + frac(x_0, 4))ubs(n)_1 + (x_3 + frac(x_2, 2) + frac(x_1, 4) + frac(x_0, 8))ubs(n_0)]}
$

The second simplification comes from the fact that $e^(i pi x ubs(n))ubs(H)ket(0) = ubs(H)ket(x)$, indeed:
$
    x = 0 --> cancel(e^(i pi ubs(n) dot 0))ubs(H)ket(0) = ubs(H)ket(0) \
    x = 1 --> e^(i pi ubs(n) dot 1)ubs(H)ket(1) = (-1)^(ubs(n))frac(1, sqrt(2))(ket(0) + ket(1)) = frac(1, sqrt(2))(ket(0) - ket(1)) = ubs(H)ket(1)
$

Therefore this relation can be applied to all *integer* coefficients in the $cal(bold(Z))^x$ expression:
$
    exp[(i pi(x_0 ubs(n)_3 + x_1 ubs(n)_2) + x_2 ubs(n)_1 + x_3 ubs(n)_0)]ubs(H)_3 ubs(H)_2 ubs(H)_1 ubs(H)_0 ket(0)ket(0)ket(0)ket(0) \
    = [exp(i pi x_0 ubs(n)_3)ubs(H)_3][exp(i pi x_1 ubs(n)_2)ubs(H)_2][exp(i pi x_2 ubs(n)_1)ubs(H)_1][exp(i pi x_3 ubs(n)_0)ubs(H)_0]ket(0)ket(0)ket(0)ket(0) \
    = ubs(H)_3 ubs(H)_2 ubs(H)_1 ubs(H)_0 ket(x_0)ket(x_1)ket(x_2)ket(x_3)
$

but the are also *fractional* coefficients in the expression for $ubs(U)_("FT")$, so the complete expression is:
$
    ubs(U)_("FT")ket(x_3)ket(x_2)ket(x_1)ket(x_0) = \
    exp{i pi[frac(1, 2)x_0 ubs(n)_2 + (frac(1, 2)x_1 + frac(1, 4)x_0)ubs(n)_1 + (frac(1, 2)x_2 + frac(1, 4)x_1 + frac(1, 8)x_0)ubs(n)_0]}ubs(H)_3 ubs(H)_2 ubs(H)_1 ubs(H)_0 ket(x_0)ket(x_1)ket(x_2)ket(x_3)
$

All $ubs(n)$ operators in this expression are *commutative*, because they act on different qubits. We can therefore use a property of the exponential function:
$
    e^(A + B) = e^A e^B
$

This property is valid if and only if $A B = B A$, like in our case. So we can group the expression above by rewriting it as a *product of exponentials*:
$
    ubs(U)_("FT")ket(x_3)ket(x_2)ket(x_1)ket(x_0) = ubs(H)_3 exp(i pi frac(1, 2)x_0 ubs(n)_2)ubs(H)_2 exp[i pi(frac(x_1, 2) + frac(x_0, 4))ubs(n)_1] ubs(H)_1 exp[i pi(frac(x_2, 2) + frac(x_1, 4) + frac(x_0, 8))ubs(n)_0]ubs(H)_0 ket(x_0)ket(x_1)ket(x_2)ket(x_3)
$

Note that while $exp$ and $ubs(H)$ operators can be rearranged freely when they act on *different* qubit, when they act on the same qubit this is not true. In this example, the $exp$ on qubit 0 and $ubs(H)_0$ cannot be rearranged.

To better write this expression, we introduce two 2-qubit operators:
$
    ubs(V)_(i j) = exp(frac(i pi ubs(n)_i ubs(n)_j, 2^(|i - j|))) \
    ubs(P)ket(x_3)ket(x_2)ket(x_1)ket(x_0) = ket(x_0)ket(x_1)ket(x_2)ket(x_3)
$
where $ubs(P)$ is just a *permutation* operator.

Now we can rewrite $ubs(U)_("FT")$ in this way:
$
    ubs(U)_("FT")ket(x_3)ket(x_2)ket(x_1)ket(x_0) = ubs(H)_3 (ubs(V)_32 ubs(H)_2)(ubs(V)_31 ubs(V)_21 ubs(H)_1)(ubs(V)_30 ubs(V)_20 ubs(V)_10 ubs(H)_0)ubs(P)ket(x_0)ket(x_1)ket(x_2)ket(x_3)
$

and this ends the demonstration on how to build $ubs(U)_("FT")$ out of 1- and 2-qubit unitary gates, which also proves that $ubs(U)_("FT")$ is unitary.

#figure(
    image("assets/47c991593a441c28a98ae9401f8a22a3.png", width: 72%),
    caption: [Circuit that implements QFT for $n = 4$ qubits]
)

== Quantum period finding

Let's resume our problem about finding the period of a function:
$
    ubs(U)_f ket(x)_n ket(0)_(n_0) = ket(x)_n ket(f(x))_(n_0)
$
where $n_0$ is the smallest integer such that $2^(n_0) >= M$ with $0 <= f(x) < M$ and $n = 2n_0$.

The quantum Fourier transform is very efficient, but its result cannot be used directly because when we measure the output register we don't get any coefficient.

To find the period of $f$, first the input register is prepared in a linear superposition of all possible input states, while the output register is initialized to $ket(0)$:
$
    ubs(U)_f (ubs(H)^(times.circle n)ket(0)_n ket(0)_(n_0)) = frac(1, sqrt(2^n))sum_(x = 0)^(2^n - 1)ket(x)_n ket(f(x))_(n_0)
$

Next we measure the *output* register, which causes a collapse of the *input* register to all states related to the outcome:
$
    ket(psi)_n = frac(1, sqrt(m))sum_(k = 0)^(m - 1)ket(x_0 + k r)_n ket(f(x_0))_(n_0)
$
where:
- $r$ is the period of $f$;
- $m$ is the number of input values for which $f$ has value $f(x_0)$;
- $x_0$ is the smallest of such input values such that $0 <= x_0 < r$

In other words, when we measure the output register the input register collapses in a state composed of $m$ values. Each of these $m$ values has a distance $k r$ (i.e. a *multiple* of the period) from $x_0$.

Now we apply the QFT to the input register:
$
    ket(Psi') & = ubs(U)_("FT") frac(1, sqrt(m))sum_(k = 0)^(m - 1)ket(x_0 + k r)_n \
    & = sum_(y = 0)^(2^n - 1)exp(frac(2pi i x_0 y, 2^n))frac(1, sqrt(2^n m))(sum_(k = 0)^(m - 1)exp[frac(2pi i k r y, 2^n)])ket(y)
$
and then we measure the input qubits.

For $N = 2^n = m r$, the probability of getting $y = j m$ (i.e. a *multiple* of $m$) as an outcome is $frac(1, r)$. Instead, the probability of getting a non-multiple of $m$ is 0.

Let's consider the case of $N = m r$ for simplicity. In this case:
$
    frac(y, N) = frac(j_0 dot cancel(m), cancel(m) dot r_0) = j_0/r_0
$
therefore:
- if $gcd(j_0, r_0) = 1$, then $r = r_0$ is the period of $f$;
- if $gcd(j_0, r_0) != 1$, then $r_0$ is not the period of $f$, but it's one of its *factors*, so:
  + we store this value $r_0$;
  + we repeat the procedure again, getting another value $r_1$;
  + if $f(x_0 + r_0 r_1) = f(x_0)$ then $r = r_0 r_1$ is the period of $f$, otherwise we will repeat again the procedure

#highlight(fill: yellow)[Quantum period finding using the QFT is a generalization of the Simon's problem. Here we deal with the standard sum operation], i.e. we have a function $f$ for which $f(x + y) = f(x) <=> x - y = k r$. #highlight(fill: yellow)[In the Simon's problem instead we dealt with the *modulo 2 sum* operation], i.e. the function was $f(x plus.circle y) = f(x) <=> x plus.circle y = a$.

=== Why we need the QFT

One may think that we should have stopped at this point:
$
    ket(psi)_n = frac(1, sqrt(m))sum_(k = 0)^(m - 1)ket(x_0 + k r)ket(f(x_0))_(n_0)
$

We could have repeat the process multiple times to get multiple values $x_0_i + k_i r$, then we could have found $r$ pretty easily.

But this is not true, because not only the $k$ is different between these values, but also the $x_0$, so a simple subtraction would not reveal nothing about $r$, e.g.:
- measurement 1 gives $x_0 + k r$;
- measurement 2 gives $x_0^' + k^' r$

$
    x_0 + k r - (x_0^' + k^' r) = x_0 - x_0^' + (k - k^')r
$

which is useless to get information about $r$.

= Quantum error correction

Quantum computers provide a significant speedup for specific problems, but they are also extremely *fragile*. This fragility highly impacts the practical usage of quantum computers.

Avoiding errors in quantum computers would require an unrealistic degree of isolation from the environment, therefore *error correction* is unavoidable.

Error detection (and correction) may seem impossible in quantum systems at first glance:
- if we measure the state to try to detect an error, we destroy it in an irreversible way;
- quantum information cannot be *cloned*;
- errors in quantum systems can be much more subtle than the ones that may occur in a classical system. In this last case, all can happen is a *bit flipping error*. In a quantum system instead we have to deal also with *phase errors*, which are much more subtle

But despite all of these, quantum error correction is nonetheless possible.

== Three-qubit encoding

In this scheme, each logical qubit is encoded using multiple (3, in this case) physical qubits:
$
    ket(psi) = alpha ket(0) + beta ket(1) = alpha ket(000) + beta ket(111) equiv alpha ket(overline(0)) + beta ket(overline(1)) in cal(S)
$

We can represent a *single bit flip* in one of these physical qubit as an $ubs(X)$ gate:
$
    ket(psi_0) = ubs(X)_0 ket(psi) = alpha ket(001) + beta ket(110) in cal(S)_0 \
    ket(psi_1) = ubs(X)_1 ket(psi) = alpha ket(010) + beta ket(101) in cal(S)_1 \
    ket(psi_2) = ubs(X)_2 ket(psi) = alpha ket(100) + beta ket(011) in cal(S)_2
$

$cal(S), cal(S)_0, cal(S)_1$ and $cal(S)_2$ are different subspaces and they are mutually disjoint. So an $ubs(X)_i$ gate applied on state $ket(psi)$ transfers the state into a different subspace.

#figure(
    image("assets/5bce12a35f007b94c0d5abc08b3f93ba.png", width: 40%),
    caption: [Representation of subspaces]
)

Since all these subspaces are mutually disjoint, a *suitable measurement* can detect in *which* state the qubit is without altering it. The measurement scheme we are looking for has to discriminate between the subsystems, but not within each subsystem. In other words we want to know if we are in state $cal(S)$ (no error occurred) or in one of $cal(S)_0, cal(S)_1, cal(S)_2$, but we don't want to know in which state $cal(S)_i$ we are, because a measurement that returns this information would destroy the qubit.

To perform this discrimination, a single-qubit measurement is not enough. A two-qubit measurement must be used to unambiguously identify the error.

#figure(
    table(
        columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
        [], [$ket(000)$], [$ket(111)$], [$ket(001)$], [$ket(110)$], [$ket(010)$], [$ket(101)$], [$ket(100)$], [$ket(011)$],
        [$ubs(Z)_2 ubs(Z)_1$], [$+1$], [$+1$], [$+1$], [$+1$], [$-1$], [$-1$], [$-1$], [$-1$],
        [$ubs(Z)_1 ubs(Z)_0$], [$+1$], [$+1$], [$-1$], [$-1$], [$-1$], [$-1$], [$+1$], [$+1$]
    ),
    caption: [Possible outcomes for $ubs(Z)_2 ubs(Z)_1$ and $ubs(Z)_1 ubs(Z)_0$ measurements]
)

By looking at the table above, it's evident that each subsystem $cal(S)_i$ (i.e. each pair of columns) has a different outcome, therefore we can discriminate between the subsystems.

The values of $alpha$ and $beta$ are not accessed, therefore the linear superposition is preserved. This measurement does not destroy the quantum state.

The two measurements commute:
$
    (ubs(Z)_2 cancel(ubs(Z)_1))(cancel(ubs(Z)_1) ubs(Z)_0) = ubs(Z)_2 ubs(Z)_0 = ubs(Z)_0 ubs(Z)_2 = (ubs(Z)_1 ubs(Z_0))(ubs(Z)_2 ubs(Z)_1)
$

The application of $ubs(X)_k$ restores the original state:
$
    ubs(X)_k ket(psi_k) = ket(psi)
$

== Single- and two-qubit observables

A generic two-qubit initial state is given:
$
    ket(psi) = alpha_00 ket(00) + alpha_01 ket(01) + alpha_10 ket(10) + alpha_11 ket(11)
$

#figure(
    table(
        columns: (auto, auto, auto),
        [*outcome*], [*probability*], [*state after measurement*],
        [$+1$], [$p = |alpha_00|^2 + |alpha_10|^2$], [$ket(psi') = frac(1, sqrt(p))(alpha_00 ket(00) + alpha_10 ket(10))$],
        [$-1$], [$p = |alpha_01|^2 + |alpha_11|^2$], [$ket(psi') = frac(1, sqrt(p))(alpha_01 ket(01) + alpha_11 ket(11))$]
    ),
    caption: [Result of measurement of $ubs(Z)_0$]
)

#figure(
    table(
        columns: (auto, auto, auto),
        [*outcome*], [*probability*], [*state after measurement*],
        [$+1$], [$p = |alpha_00|^2 + |alpha_01|^2$], [$ket(psi') = frac(1, sqrt(p))(alpha_00 ket(00) + alpha_01 ket(01))$],
        [$-1$], [$p = |alpha_10|^2 + |alpha_11|^2$], [$ket(psi') = frac(1, sqrt(p))(alpha_10 ket(10) + alpha_11 ket(11))$]
    ),
    caption: [Result of measurement of $ubs(Z)_1$]
)

#figure(
    table(
        columns: (auto, auto, auto),
        [*outcome*], [*probability*], [*state after measurement*],
        [$+1$], [$p = |alpha_00|^2 + |alpha_11|^2$], [$ket(psi') = frac(1, sqrt(p))(alpha_00 ket(00) + alpha_11 ket(11))$],
        [$-1$], [$p = |alpha_10|^2 + |alpha_11|^2$], [$ket(psi') = frac(1, sqrt(p))(alpha_01 ket(01) + alpha_10 ket(10))$]
    ),
    caption: [Result of measurement of $ubs(Z)_0 ubs(Z)_1$]
)

The point here is that the coherence of $ket(psi)$ is destroyed, but the linear superposition between *pair* of states is preserved after the measurement.

== Two-qubit observables and three-qubit states

Generic three-qubit state:
$
    ket(psi) = sum_(x_2, x_1, x_0 = 0, 1)alpha_(x_2, x_1, x_0)ket(x_2\, x_1\, x_0)
$

#figure(
    table(
        columns: (auto, auto),
        [*outcome*], [*state after measurement*],
        [$+1$], [$ket(psi') = frac(1, sqrt(p))sum_(x_2 = 0, 1)(alpha_(0, 0, x_2)ket(x_2\, 0\, 0) + alpha_(1, 1, x_2)ket(x_2\, 1\, 1))$],
        [$-1$], [$ket(psi') = frac(1, sqrt(p))sum_(x_2 = 0, 1)(alpha_(0, 1, x_2)ket(x_2\, 0\, 1) + alpha_(1, 0, x_2)ket(x_2\, 1\, 0))$]
    ),
    caption: [Result of measurement of $ubs(Z)_0 ubs(Z)_1$]
)

#figure(
    table(
        columns: (auto, auto),
        [*outcome*], [*state after measurement*],
        [$+1$], [$ket(psi') = frac(1, sqrt(p))sum_(x_0 = 0, 1)(alpha_(x_0, 0, 0)ket(0\, 0\, x_0) + alpha_(x_0, 1, 1)ket(1\, 1\, x_0))$],
        [$-1$], [$ket(psi') = frac(1, sqrt(p))sum_(x_0 = 0, 1)(alpha_(x_0, 0, 1)ket(1\, 0\, x_0) + alpha_(x_0, 1, 0)ket(1\, 0\, x_0))$]
    ),
    caption: [Result of measurement of $ubs(Z)_1 ubs(Z)_2$]
)

When combined, $ubs(Z)_0 ubs(Z)_1$ and $ubs(Z)_1 ubs(Z)_2$ cut the Hilber space in four 2-dimensional subspaces.

== Implementation on a quantum circuit

This implementation requires some *ancillar qubits* prepared in state $ket(0)$. Then a sequence of 2 CNOTs is applied (one for each measurement) and the state of the ancillars is measured.

#figure(
    image("assets/849faead64c6f3f160ec32f584328f29.png", height: 39%),
    caption: [Implementation of 2-qubit measurements]
)

In this circuit:
- the two ancillars + qubit 0 and 1 + CNOT 1 and 2 + M1 implements the measurement $ubs(Z)_2 ubs(Z)_1$;
- the two ancillars + qubit 1 and 2 + CNOT 3 and 4 + M2 implement the measurement $ubs(Z)_1 ubs(Z)_0$

Combined together, these measurements give two possible outcomes. Each outcome corresponds to a pair of qubits in the linear superposition.

== Encoded quantum gates

Quantum gates too can be encoded using the 3-qubit encoding:
$
    overline(ubs(X)) = ubs(X)_0 ubs(X)_1 ubs(X)_2 quad quad overline(ubs(Y)) = i overline(ubs(X) ubs(Z)) quad quad overline(ubs(Z)) = ubs(Z)_0 ubs(Z)_2 ubs(Z)_2 quad quad overline(ubs(H)) = frac(1, sqrt(2))(overline(ubs(X)) + overline(ubs(Z))) \
    
$

In fact:
$
    overline(ubs(X))ket(overline(0)) = ubs(X)_0 ubs(X)_1 ubs(X)_2 ket(000) = ket(111) = ket(overline(1))
$
and so on.

== General principles in quantum error correction

We start from a space $cal(S)$, we apply our gates for the computation and, if no error occurred, we are still in $cal(S)$. Each possible error instead maps $cal(S)$ to a different 2-dimensional subspace $cal(S)_i$.

In order to discriminate between these subspaces, the size of the Hilber space $2^n$ should be bigger than $2(1 + n)$, which is the size of $cal(S)$ plus the size of all $cal(S)_i$. This is the reason why we need $n >= 3$ qubits to perform error correction.

The measurement identifies the subspace $cal(S)_i$, but it does not provide clues about coefficients $alpha$ and $beta$.

== 5-qubit error-correcting code

We have an *observable* which can be written as a sum of eigenvalues and eigenstates:
$
    A = sum_i a_i ketbra(a_i)
$

If the outcome of the measurement is $a_i$, the state of this observable will collapse to $ket(a_i)$.

Now, let's consider a general case in which all errors can happen, not just a bit flip. These errors can be sumarized by a single application of an $ubs(X), ubs(Y)$ or $ubs(Z)$ gate.

We need therefore to find the value of $n$ for which $2^n >= 2(1 + 3n)$ (the $n$ is now multiplied by 3 because there are 3 types of error that can happen). This $n$ is the number of *physical* qubits we need to encode a single logical qubit.

The solution is $n >= 5$.

We need also a *set of measurements* which allows us to discriminate between the subspaces $cal(S)_i$. We need 4 different measurements, because $k >= 4$ is the one that satisfies the condition $2^k >= 3n + 1$.

Each measurement has to satisfy these properties:
- it must be equal to the identity operator $ubs(1)$ when squared;
- they should *commute* with each other

An example of such set of measurements is this one:
$
    ubs(M)_0 = ubs(Z)_1 ubs(X)_2 ubs(X)_3 ubs(Z)_4 quad quad ubs(M)_1 = ubs(Z)_2 ubs(X)_3 ubs(X)_4 ubs(Z)_0 \
    ubs(M)_2 = ubs(Z)_3 ubs(X)_4 ubs(X)_0 ubs(Z)_1 quad quad ubs(M)_3 = ubs(Z)_4 ubs(X)_0 ubs(X)_1 ubs(Z)_2
$

Now that we have a set of measurements, we can encode our logical bits:
$
    ket(overline(0)) = 1/4(1 + ubs(M)_0)(1 + ubs(M)_1)(1 + ubs(M)_2)(1 + ubs(M)_3)ket(00000) \
    ket(overline(1)) = 1/4(1 + ubs(M)_0)(1 + ubs(M)_1)(1 + ubs(M)_2)(1 + ubs(M)_3)ket(11111)
$

$ket(overline(0))$ and $ket(overline(1))$ are orhogonal because each $ubs(M)$ flips two qubits, so they have an even and odd number of qubits in state 1 respectively.

These states are normalized. We can check it with the bra-ket product:
$
    braket(overline(0)) & = 1/16braket(00000, [(1 + ubs(M)_0)(1 + ubs(M)_1)(1 + ubs(M)_2)(1 + ubs(M)_3)]^2, 00000) \
    & = braket(00000, (1 + ubs(M)_0)(1 + ubs(M)_1)(1 + ubs(M)_2)(1 + ubs(M)_3), 00000)
$
where each $(1 + ubs(M)_i)^2 = 1 + ubs(M)_i + ubs(M)_i + ubs(M)_i^2 = 2(1 + ubs(M)_i)$ (because $ubs(M)_i^2 = ubs(1)$).

Our 4 operator $ubs(M)_i$ allow us to discriminate between 16 different subspaces: 15 with a corruption and 1 without:
#figure(
    image("assets/155d0b07f3dca5fbf2058f2b4b0f10ab.png", height: 14%),
    caption: [Outcome for each $ubs(M)_i$ and each possible corruption]
)

Each of these cases has a unique set of values for the $ubs(M)_i$ operators.

The table above shows the sign of the eigenvalues. If no error occurred, all eigenvalues are positive.

Differently corrupted states are orthogonal. To demonstrate this, one can use a measurement operator $ubs(M)_i$ that commutes with one of the error operators and anticommutes with the other one:
$
    braket(overline(0), ubs(X)_0 ubs(Y)_0, overline(0)) & = braket(overline(0), ubs(X)_0 ubs(M)_2^2 ubs(Y)_0, overline(0)) \
    & = braket(overline(0), (ubs(M)_2 ubs(X)_0)(-ubs(Y)_0 ubs(M)_2), overline(0)) \
    & = -braket(overline(0), ubs(X)_0 ubs(Y)_0, overline(0))
$

#figure(
    image("assets/1cff48fafacd5458c13c45c0531f42c8.png", height: 19%),
    caption: [Circuit that implements a measurement $ubs(M)_i$]
)

In the circuit above, $A$ is the observable and $ubs(P)_0 = 1/2(1 + A)$ and $ubs(P)_1 = 1/2(1 - A)$ are the projectors on the eigenspaces corresponding to $a_1 = +1$ and $a_2 = -1$ respectively.