import std.array : empty;
import std.stdio;
import std.algorithm : map, fold, splitter, filter;
import std.range : walkLength;
import std.string : strip;
import std.typecons : Yes;
import std.uni : byCodePoint;

struct Line {
	size_t chars;
	size_t words;
}

struct Output {
	size_t lines;
	size_t words;
	size_t chars;
}

Output combine(Output a, Line b) pure nothrow {
	return Output(a.lines + 1, a.words + b.words, a.chars + b.chars);
}

bool split(char s) pure nothrow {
	return s == ' ' || s == '\t';
}

Line toLine(char[] l) pure {
	return Line(
		l.byCodePoint.walkLength,
		l.splitter!(a => a == ' ' || a == '\t')
			.map!strip
			.filter!(l => !l.empty)
			.walkLength
		);
}

void main(string[] args) {
	auto f = File(args[1]);
	Output o = f
		.byLine(Yes.keepTerminator)
		.map!(l => toLine(l))
		.fold!(combine)(Output(0, 0, 0));

	writefln!"%u %u %u %s"(o.lines, o.words, o.chars, args[1]);
}
