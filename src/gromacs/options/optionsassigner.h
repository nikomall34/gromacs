/*
 *
 *                This source code is part of
 *
 *                 G   R   O   M   A   C   S
 *
 *          GROningen MAchine for Chemical Simulations
 *
 * Written by David van der Spoel, Erik Lindahl, Berk Hess, and others.
 * Copyright (c) 1991-2000, University of Groningen, The Netherlands.
 * Copyright (c) 2001-2009, The GROMACS development team,
 * check out http://www.gromacs.org for more information.

 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * If you want to redistribute modifications, please consider that
 * scientific software is very special. Version control is crucial -
 * bugs must be traceable. We will be happy to consider code for
 * inclusion in the official distribution, but derived work must not
 * be called official GROMACS. Details are found in the README & COPYING
 * files - if they are missing, get the official version at www.gromacs.org.
 *
 * To help us fund GROMACS development, we humbly ask that you cite
 * the papers on the package - you can find them in the top README file.
 *
 * For more info, check our website at http://www.gromacs.org
 */
/*! \libinternal \file
 * \brief
 * Declares gmx::OptionsAssigner.
 *
 * This header is only needed when implementing option parsers.
 *
 * \author Teemu Murtola <teemu.murtola@cbr.su.se>
 * \inlibraryapi
 * \ingroup module_options
 */
#ifndef GMX_OPTIONS_OPTIONSASSIGNER_H
#define GMX_OPTIONS_OPTIONSASSIGNER_H

#include <string>

#include "../utility/common.h"

namespace gmx
{

class Options;

/*! \libinternal \brief
 * Decorator class for assigning values to Options.
 *
 * This class extends the interface of an Options object by providing methods
 * to set values for options.  It also keeps track of necessary state variables
 * to assign values to options in subsections within the Options object.
 * Typical use (without error handling):
 * \code
   gmx::options::Options options("name", "Title");
   // Set up options

   gmx::options::OptionsAssigner assigner(&options);
   assigner.start();
   assigner.startOption("opt1");
   assigner.appendValue("3");
   assigner.finishOption();
   assigner.startSubSection("section");
   assigner.startOption("opt2"); // Now in the subsection
   assigner.appendValue("yes");
   assigner.finishOption();
   assigner.finishSubSection()
   assigner.startOption("opt3"); // Again in the main options
   assigner.appendValue("2");
   assigner.finishOption();
   assigner.finish();
 * \endcode
 *
 * \inlibraryapi
 * \ingroup module_options
 */
class OptionsAssigner
{
    public:
        /*! \brief
         * Creates an object that assigns to the given object.
         */
        explicit OptionsAssigner(Options *options);
        ~OptionsAssigner();

        /*! \brief
         * Sets the assigner to recognize boolean options with a "no" prefix.
         *
         * With this option set, \c startOption("noname") is interpreted as
         * \c startOption("name") followed by \c appendValue("no"), if there is
         * no option by the name "noname", but there is a boolean option with
         * name "name".
         *
         * By default, the prefix is not recognized.
         *
         * Can be set or cleared at any time, and will have effect on all
         * subsequent calls of startOption().
         *
         * Does not throw.
         */
        void setAcceptBooleanNoPrefix(bool bEnabled);
        /*! \brief
         * Sets the assigner to find options in non-active sections.
         *
         * By default, options are only looked for in the currently active
         * subsection.  With this option set, if no matching option is found in
         * the current section, a breadth-first search is performed, first on
         * all subsections of the current section, and then going up one level
         * at a time.  The first matching option is used, and the current
         * section is changed to the section that contains the matching option.
         *
         * Can be set or cleared at any time, and will have effect on all
         * subsequent calls of startOption().
         *
         * Does not throw.
         */
        void setNoStrictSectioning(bool bEnabled);

        /*! \brief
         * Start assigning values.
         *
         * Does not throw.
         */
        void start();
        /*! \brief
         * Start assigning values to options in a subsection.
         *
         * \param[in] name  Name of the subsection to start assigning to.
         * \throws InvalidInputError if such a subsection is not found.
         *
         * Strong exception safety guarantee.
         */
        void startSubSection(const char *name);
        /*! \brief
         * Start assigning values for an option.
         *
         * \param[in] name  Name of the option to start assigning to.
         * \throws InvalidInputError if such an option is not found, or if the
         *      option is specified more than once but doesn't support it.
         *
         * Strong exception safety guarantee.
         */
        void startOption(const char *name);
        /*! \brief
         * Appends a value to the value list of the current option.
         *
         * \param[in] value  String representation of the value to assign.
         * \throws InvalidInputError if the value cannot be converted or if
         *      there are too many values for an option.
         *
         * Basic exception safety guarantee:
         * If this method throws, erroneous values are ignored, but it is
         * possible to continue assigning values to the same option.  However,
         * if \p value would result in more than one value, and some of them
         * can be converted, but some result in errors, it is currently
         * possible that some values have been added to the option even if an
         * exception is thrown.
         *
         * Strong exception safety guarantee if the option provides value
         * conversion with the same guarantee.  All options where a single
         * input value always results in a single output value provide this.
         *
         * \internal
         * This method provides the same exception safety guarantee as the
         * OptionStorageTemplate::convertValue() method of the storage class
         * implementing the option where the value is assigned to.
         */
        void appendValue(const std::string &value);
        /*! \brief
         * Finish assigning values for the current option.
         *
         * \throws InvalidInputError if the set of values since startOption()
         *      is not valid.
         *
         * If this method throws, it returns to the state where the option was
         * before startOption(), i.e., all values added with appendValue()
         * since the last startOption() are discarded.
         *
         * Independent of whether the method throws, the option opened with
         * startOption() will be closed after the call.
         */
        void finishOption();
        /*! \brief
         * Finish assigning values to a subsection.
         *
         * Does not throw.
         */
        void finishSubSection();
        /*! \brief
         * Finish assigning options through the object.
         *
         * Does not throw.
         */
        void finish();

    private:
        class Impl;

        PrivateImplPointer<Impl> impl_;
};

} // namespace gmx

#endif
